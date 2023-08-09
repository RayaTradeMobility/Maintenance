// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/installationcaseModel.dart';
import 'package:maintenance/Models/repaircaseModel.dart';
import 'package:maintenance/Views/installationScreen.dart';
import 'package:maintenance/Views/repairScreen.dart';

import '../Constants/Constants.dart';

class OrderScreen extends StatefulWidget {
  final String mobileUsername , siteRequestId;

  const OrderScreen({Key? key, required this.mobileUsername , required this.siteRequestId}) : super(key: key);

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
  List<RepairCases> repairList = [];
  ScrollController controller = ScrollController();
  API api = API();
  bool _isLoading = false;
  bool _isLoading2 = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // ignore: avoid_types_as_parameter_names
    api.fetchInstallation(widget.mobileUsername).then((InstallationModel) {
      setState(() {
        installationList = InstallationModel.installationCases!;
        searchController = TextEditingController();
        _isLoading =true ;
      });
    });
    // ignore: avoid_types_as_parameter_names
    api.fetchRepair(widget.siteRequestId).then((RepairModel) {
      setState(() {
        repairList = RepairModel.repairCases!;
        searchController = TextEditingController();
        _isLoading2 =true ;

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
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        title: customSearchBar,
        centerTitle: true,
        automaticallyImplyLeading: true,
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
                    color: MyColorsSample.primary.withOpacity(0.8),
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
                      child:_isLoading==false? const Center(child:CircularProgressIndicator()):  ListView.builder(
                        controller: controller,
                        itemCount: installationList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < installationList.length) {
                            return CustomCardInstallation(
                              mobileUsername: widget.mobileUsername,
                              customerName:
                                  installationList[index].customerFullName!,
                              mobileNumber:
                                  installationList[index].mobileNumber!,
                              city: installationList[index].city!,
                              address: installationList[index].address!,
                              symptom: installationList[index].symptom!,
                              model: installationList[index].model!,
                              serial: installationList[index].serial!,
                              category: installationList[index].category!,
                              brand: installationList[index].brand!,
                              symptomCategory:
                                  installationList[index].symptomCategory!,
                              request_ID: installationList[index].requestID!,
                            );
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
                      child:_isLoading2==false? const Center(child:CircularProgressIndicator()): ListView.builder(
                        controller: controller,
                        itemCount: repairList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < repairList.length) {
                            return CustomCardRepair(

                              customerName:
                              repairList[index].customerName!,
                              mobile_Number:
                              repairList[index].mobileNumber!,
                              work_Order_ID: repairList[index].workOrderID!,
                              primary_Serial_Number: repairList[index].primarySerialNumber!,
                              product_Model: repairList[index].productModel!,
                              brand: repairList[index].brand!,
                              siteRequestId: widget.siteRequestId,

                            );
                          }
                          return null;
                        },
                      ),                    ),
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
  final String mobileUsername,
      customerName, mobileNumber, city, address, symptom, model, serial,
      category, brand, symptomCategory, request_ID;

  const CustomCardInstallation(
      {Key? key,
      required this.mobileUsername, required this.customerName, required this.mobileNumber, required this.city,
      required this.address, required this.symptom, required this.model, required this.serial, required this.category,
      required this.brand, required this.symptomCategory, required this.request_ID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InstallationScreen(
                    mobileUsername: mobileUsername,
                    customerName: customerName,
                    mobileNumber: mobileNumber,
                    city: city,
                    address: address,
                    symptom: symptom,
                    model: model,
                    serial: serial,
                    category: category,
                    brand: brand,
                    symptomCategory: symptomCategory,
                    requestID: request_ID,
                  )),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
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
  final String customerName , mobile_Number ,work_Order_ID, primary_Serial_Number ,product_Model , brand , siteRequestId ;
  const CustomCardRepair({
    Key? key, required this.customerName, required this.mobile_Number, required this.work_Order_ID,
    required this.primary_Serial_Number, required this.product_Model, required this.brand, required this.siteRequestId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  RepairScreen(workOrderId: work_Order_ID,
              siteRequestId: siteRequestId)),
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
                      '${customerName.replaceAll("\n", " ")} : الاسم ',

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
                height: 7.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$mobile_Number :رقم الموبايل',
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
                height: 7.0,
              ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$primary_Serial_Number :السريال',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.code,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 7.0,
              ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$work_Order_ID :رقم العامل',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.credit_card_outlined,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 7.0,
              ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$product_Model :المنتج',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.category,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 7.0,
              ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$brand :المركه',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.branding_watermark,
                      color: Colors.grey,
                    ),
                  ]),
            ],
          )),
    );
  }
}
