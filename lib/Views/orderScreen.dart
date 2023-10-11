// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/installationcaseModel.dart';
import 'package:maintenance/Models/repaircaseModel.dart';

import '../Constants/Constants.dart';
import '../Constants/order_installation_cart.dart';
import '../Constants/order_repair_cart.dart';
import 'package:http/http.dart' as http;

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

  // String faultValue = '';
  // List<String> faults = [''];

  String repairInValue = '';
  late int idRepairValue;

  List<int> repairInID = [];
  List<String> repairIn = [""];

  String faultTypeValue = '';
  late int idSpareValue;

  List<int> spareTypeID = [];
  List<String> spareCodeName = [""];

  @override
  void initState() {
    super.initState();
    _loadData();
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

  Future<void> _loadData() async {
    await fetchSpareCodeType();
    await fetchRepairIn();
    if (kDebugMode) {
      print('Calling');
    }
  }

  Future<void> fetchSpareCodeType() async {
    try {
      final response = await http.get(Uri.parse(
          'http://www.rayatrade.com/TechnicionMobileApi//api/User/GetSpareCodeType'));
      final data = json.decode(response.body);
      final spareType = data['spareTypes'];
      for (var e in spareType) {
        spareTypeID.add(e['id']);
        spareCodeName.add(e['name']);
      }
      setState(() {});
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print('Error fetching spareCodeType: $error');
      }
    }
  }

  Future<void> fetchRepairIn() async {
    try {
      final response = await http.get(Uri.parse(
          'http://www.rayatrade.com/TechnicionMobileApi/api/User/GetRepairIN'));
      final data = json.decode(response.body);

      final repairType = data['repairINs'];

      for (var e in repairType) {
        repairIn.add(e['name']);
        repairInID.add(e['id']);
      }

      setState(() {});
      // ignore: empty_catches
    } catch (error) {}
  }

//   Future<void> fetchFaultCode() async {
//     try {
//       final response = await http.get(Uri.parse(
//           'http://www.rayatrade.com/TechnicionMobileApi/api/User/GetFaultCode'));
//       final data = json.decode(response.body);
//       if (kDebugMode) {
//         print(response.body);
//       }
//       setState(() {
//         faults.addAll(List<String>.from(data['faults']));
//       });
// // ignore: empty_catches
//     } catch (error) {}
//   }

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
                          ? const Center(child: CircularProgressIndicator())
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
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          3),
                                  child: const Center(
                                      child: Text('No data available')),
                                );
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
                          ? const Center(child: CircularProgressIndicator())
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
