// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/installationcaseModel.dart';
import 'package:maintenance/Models/repaircaseModel.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants/Constants.dart';
import '../Constants/order_installation_cart.dart';
import '../Constants/order_repair_cart.dart';

class OrderScreen extends StatefulWidget {
  final String mobileUsername, siteRequestId;

  const OrderScreen(
      {Key? key, required this.mobileUsername, required this.siteRequestId})
      : super(key: key);

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
        _isLoading = true;
      });
    });
    // ignore: avoid_types_as_parameter_names
    api.fetchRepair(widget.siteRequestId).then((RepairModel) {
      setState(() {
        repairList = RepairModel.repairCases!;
        searchController = TextEditingController();
        _isLoading2 = true;
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
                      child: _isLoading == false
                          ? Center(
                              child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    mainAxisSpacing: 3.0,
                                    crossAxisSpacing: 3.0,
                                    childAspectRatio: 3 / 1,
                                    crossAxisCount: 1,
                                    children: List.generate(
                                      4,
                                      (index) => Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  7.4,
                                              child: Card(
                                                elevation: 10,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Container(),
                                              ),
                                            ),
                                            const SizedBox(height: 5.0),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              height: 8.0,
                                              color: Colors.grey[300],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          : ListView.builder(

                              controller: controller,
                              itemCount: installationList.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < installationList.length) {
                                  return CustomCardInstallation(
                                    mobileUsername: widget.mobileUsername,
                                    customerName: installationList[index]
                                        .customerFullName!,
                                    mobileNumber:
                                        installationList[index].mobileNumber!,
                                    city: installationList[index].city!,
                                    address: installationList[index].address!,
                                    symptom: installationList[index].symptom!,
                                    model: installationList[index].model!,
                                    serial: installationList[index].serial!,
                                    category: installationList[index].category!,
                                    brand: installationList[index].brand!,
                                    symptomCategory: installationList[index]
                                        .symptomCategory!,
                                    request_ID:
                                        installationList[index].requestID!,
                                  );
                                }
                                if (index == 0) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: const Center(
                                        child: Text('No data available')),
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
                      child: _isLoading2 == false
                          ? Center(
                              child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    mainAxisSpacing: 3.0,
                                    crossAxisSpacing: 3.0,
                                    childAspectRatio: 3 / 1,
                                    crossAxisCount: 1,
                                    children: List.generate(
                                      4,
                                      (index) => Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  7.4,
                                              child: Card(
                                                elevation: 10,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Container(),
                                              ),
                                            ),
                                            const SizedBox(height: 5.0),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              height: 8.0,
                                              color: Colors.grey[300],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                          : ListView.builder(
                              controller: controller,
                              itemCount: repairList.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < repairList.length) {
                                  return CustomCardRepair(
                                    maintenanceRID:
                                        repairList[index].maintenanceRID!,
                                    mobileUsername: widget.mobileUsername,
                                    customerName:
                                        repairList[index].customerName!,
                                    mobile_Number:
                                        repairList[index].mobileNumber!,
                                    work_Order_ID:
                                        repairList[index].workOrderID!,
                                    primary_Serial_Number:
                                        repairList[index].primarySerialNumber!,
                                    product_Model:
                                        repairList[index].productModel!,
                                    brand: repairList[index].brand!,
                                    siteRequestId: widget.siteRequestId,
                                  );
                                }
                                if (index == 0) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                3),
                                    child: const Center(
                                        child: Text('No data available')),
                                  );
                                }
                                return null;
                              },
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
