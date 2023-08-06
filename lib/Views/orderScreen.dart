// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/installationcaseModel.dart';
import 'package:maintenance/Views/installationScreen.dart';
import 'package:maintenance/Views/repairScreen.dart';

class OrderScreen extends StatefulWidget {
  final String mobileUsername;
  const OrderScreen({Key? key, required this.mobileUsername}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  Widget customSearchBar = const Text("الطلبات");
  Icon customIcon = const Icon(Icons.search);
  TextEditingController searchController = TextEditingController();
  TabController? _tabController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
      GlobalKey<RefreshIndicatorState>();
  List<InstallationCases> installationList = [];
  ScrollController controller = ScrollController();
  API api = API();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // ignore: avoid_types_as_parameter_names
    api.fetchInstallation(widget.mobileUsername).then((InstallationModel) {
      setState(() {
        installationList = InstallationModel.installationCases!;
        searchController = TextEditingController();
      });
    });

  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(59, 60, 54, 20),
        title: customSearchBar,
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              if (customIcon.icon == Icons.search) {
                setState(() {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const Scaffold();
                          }),
                        );
                      },

                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    title: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'الطلبات',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                });
              } else {
                setState(() {
                  customIcon = const Icon(Icons.search);
                });
              }
            },
            icon: customIcon,
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(
                  isScrollable: false,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: Colors.black,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'تركيب',
                    ),
                    Tab(
                      text: 'تصليح',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () async {
                        _refreshIndicatorKey.currentState?.show();
                        setState(() {});
                      },
                      child: ListView.builder(
                        controller: controller,
                        itemCount: installationList.length+1,
                        itemBuilder: (BuildContext context, int index) {
                          if(index<installationList.length) {
                            return   CustomCardInstallation(customerName: installationList[index].customerFullName!,
                            mobileNumber: installationList[index].mobileNumber!, city: installationList[index].city!,
                            address: installationList[index].address!,symptom: installationList[index].symptom!,
                            model: installationList[index].model!, serial:installationList[index].serial! ,
                            category: installationList[index].category!,
                            brand: installationList[index].brand!,
                              symptomCategory: installationList[index].symptomCategory!);
                          }
                          return null;

                        },
                      ),
                    ),

                    RefreshIndicator(
                      key: _refreshIndicatorKey2,
                      onRefresh: () async {
                        _refreshIndicatorKey2.currentState?.show();
                        setState(() {});
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 1 / 0.5,
                                crossAxisCount: 1,
                                children: List.generate(
                                    8, (index) => const CustomCardRepair()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // second tab bar view widget
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCardInstallation extends StatelessWidget {
  final String customerName , mobileNumber, city , address, symptom , model , serial ,category, brand , symptomCategory;
  const CustomCardInstallation({
    Key? key, required this.customerName, required this.mobileNumber,
    required this.city, required this.address, required this.symptom,
    required this.model, required this.serial,required this.category , required this.brand, required this.symptomCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  InstallationScreen(customerName: customerName,
          mobileNumber: mobileNumber, city: city, address: address,symptom: symptom, model: model,
          serial: serial ,category :category ,   brand: brand, symptomCategory: symptomCategory,)),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$customerName :الاسم ',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$mobileNumber :رقم الموبايل',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.mobile_friendly,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$city :المدينه',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.location_city,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      address,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Text(
                      ' :العنوان',
                      style: TextStyle(color: Colors.black),
                    ),

                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$model :المنتج',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.branding_watermark_outlined,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      symptom,
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(" :العطل"),

                    const Icon(
                      Icons.tire_repair,
                      color: Colors.grey,
                    ),


                  ]),
            ],
          )),
    );
  }
}

class CustomCardRepair extends StatelessWidget {
  const CustomCardRepair({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RepairScreen()),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ':الاسم ',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                    ),
                  ]),
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Text(
              //         ':الاسم الاخير',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //       SizedBox(
              //         width: 5.0,
              //       ),
              //       Icon(
              //         Icons.account_box_rounded,
              //         color: Colors.grey,
              //       ),
              //     ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ':رقم الموبايل',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.mobile_friendly,
                      color: Colors.grey,
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ':المدينه',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.location_city,
                      color: Colors.grey,
                    ),
                  ]),
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Text(
              //         ':المنطقه',
              //         style: TextStyle(color: Colors.black),
              //       ),
              //       SizedBox(
              //         width: 5.0,
              //       ),
              //       Icon(
              //         Icons.zoom_out,
              //         color: Colors.grey,
              //       ),
              //     ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ':العنوان',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ':المنتج',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.branding_watermark_outlined,
                      color: Colors.grey,
                    ),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ': العطل',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.tire_repair,
                      color: Colors.grey,
                    ),
                  ]),
            ],
          )),
    );
  }
}
