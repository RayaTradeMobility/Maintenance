// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/getRecommendationRepairModel.dart';
import 'package:maintenance/Models/get_order_model.dart';
import 'package:maintenance/Views/homeScreen.dart';
import '../Constants/Constants.dart';
import '../Constants/Repair_cart_item.dart';
import 'package:http/http.dart' as http;

class RepairScreen extends StatefulWidget {
  final String workOrderId, siteRequestId;

  final String mobileUsername, maintenanceRID;

  const RepairScreen(
      {Key? key,
      required this.workOrderId,
      required this.siteRequestId,
      required this.mobileUsername,
      required this.maintenanceRID})
      : super(key: key);

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  Icon customIcon = const Icon(Icons.search);
  List<Spares> sparesList = [];
  bool _isLoading = false;
  TextEditingController searchController = TextEditingController();
  List<TextEditingController> controllers = [];
  List<Spares> filteredItemList = [];

  List<String> selectedSpareCodes = [];

  API api = API();

  // String faultValue = '';
  // List<String> faults = [''];

  String repairInValue = '';
  int idRepairValue = 0;
  List<int> repairInID = [];
  List<String> repairIn = [""];

  String faultTypeValue = '';
  int idSpareValue = 0;
  List<int> spareTypeID = [];
  List<String> spareCodeName = [""];

  @override
  void initState() {
    super.initState();
    fetchRepairCases();
    _loadData();
  }

  Future<void> _loadData() async {
    await fetchSpareCodeType();
    // await fetchFaultCode();
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
  void filterCrop(value) {
    setState(() {
      filteredItemList = sparesList
          .where(
              (e) => e.spareCode!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchRepairCases() async {
    RecommendationModel fetchedRecommendation =
        await api.fetchRepairCases(widget.workOrderId, widget.siteRequestId);
    setState(() {
      sparesList = fetchedRecommendation.spares!;
      _isLoading = true;
    });
  }

  void toggleSpareCode(String spareCode) {
    setState(() {
      if (selectedSpareCodes.contains(spareCode)) {
        selectedSpareCodes.remove(spareCode);
      } else {
        selectedSpareCodes.add(spareCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 1),
      appBar: AppBar(
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        title: const Text("التصليح"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search for repair code",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.blue))),
            onChanged: (value) {
              filterCrop(value);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                hint: const Text(''),
                value: faultTypeValue,
                dropdownColor: Colors.blueGrey[50],
                itemHeight: null,
                menuMaxHeight: 292,
                borderRadius: BorderRadius.circular(10),
                alignment: AlignmentDirectional.center,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    faultTypeValue = newValue!;
                    idSpareValue =
                        spareTypeID[spareCodeName.indexOf(faultTypeValue)];
                  });
                },
                items: spareCodeName.isEmpty && spareCodeName == [""]
                    ? [
                        DropdownMenuItem<String>(
                          value: null,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 180,
                            child: const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ),
                      ]
                    : spareCodeName
                        .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 180,
                            child: Center(child: Text(value)),
                          ),
                        );
                      }).toList(),
              ),
              const Text(':نوع كود القطعه  ')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                hint: const Text(''),
                value: repairInValue,
                dropdownColor: Colors.blueGrey[50],
                itemHeight: null,
                menuMaxHeight: 292,
                borderRadius: BorderRadius.circular(10),
                alignment: AlignmentDirectional.center,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    repairInValue = newValue!;
                    idRepairValue = repairInID[repairIn.indexOf(repairInValue)];
                  });
                },
                items: repairIn.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 180,
                      child: Center(child: Text(value)),
                    ),
                  );
                }).toList(),
              ),
              const Text(':Repair In  ')
            ],
          ),
          Expanded(
            child: _isLoading == false
                ? const Center(child: CircularProgressIndicator())
                : searchController.text.isEmpty
                    ? ListView.builder(
                        itemCount: sparesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          controllers.add(TextEditingController());

                          final Spares spares = sparesList[index];

                          return RepairCart(
                            model: spares.model!,
                            offering: spares.offering!,
                            spareCode: spares.spareCode!,
                            spareDescription: spares.spareDescription!,
                            ccTReference: spares.ccTReference!,
                            cost: spares.cost!,
                            finalPrice: spares.finalPrice!,
                            campaignFinalPrice: spares.campaignFinalPrice!,
                            serviceCode: spares.serviceCode!,
                            serviceLevel: spares.serviceLevel!,
                            repairModule: spares.repairModule!,
                            isChecked:
                                selectedSpareCodes.contains(spares.spareRID),
                            onChecked: () => toggleSpareCode(spares.spareRID!),
                            spareRID: spares.spareRID!,
                          );
                        },
                      )
                    : searchController.text.isNotEmpty &&
                            filteredItemList.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.search_off,
                                      size: 80,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        'No results found,\nPlease try different keyword',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : filteredItemList.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: filteredItemList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  controllers.add(TextEditingController());

                                  return RepairCart(
                                    model: filteredItemList[index].model!,
                                    offering: filteredItemList[index].offering!,
                                    spareCode:
                                        filteredItemList[index].spareCode!,
                                    spareDescription: filteredItemList[index]
                                        .spareDescription!,
                                    ccTReference:
                                        filteredItemList[index].ccTReference!,
                                    cost: filteredItemList[index].cost!,
                                    finalPrice:
                                        filteredItemList[index].finalPrice!,
                                    campaignFinalPrice: filteredItemList[index]
                                        .campaignFinalPrice!,
                                    serviceCode:
                                        filteredItemList[index].serviceCode!,
                                    serviceLevel:
                                        filteredItemList[index].serviceLevel!,
                                    repairModule:
                                        filteredItemList[index].repairModule!,
                                    isChecked: selectedSpareCodes.contains(
                                        filteredItemList[index].spareRID),
                                    onChecked: () => toggleSpareCode(
                                        filteredItemList[index].spareRID!),
                                    spareRID: filteredItemList[index].spareRID!,
                                  );
                                },
                              )
                            : const Center(
                                child:
                                    CircularProgressIndicator(), // Show CircularProgressIndicator if no data is available yet
                              ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: MyColorsSample.primary.withOpacity(0.8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4), bottom: Radius.circular(5)),
              ),
            ),
            onPressed: () async {
              if (kDebugMode) {
                print(widget.workOrderId);
                print(widget.siteRequestId);
                print(selectedSpareCodes);
                print(widget.maintenanceRID);
                print(widget.mobileUsername);
                print(idSpareValue);
                print(idRepairValue);
              }
              if (idRepairValue != 0 &&
                  idSpareValue != 0 &&
                  selectedSpareCodes.isNotEmpty) {
                GetOrder res = await api.saveOrderOneBulk(
                    widget.workOrderId,
                    widget.siteRequestId,
                    selectedSpareCodes,
                    widget.maintenanceRID,
                    widget.mobileUsername,
                    idSpareValue,
                    idRepairValue);
                if (res.code == '00') {
                  Fluttertoast.showToast(
                      msg: res.message!,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomePage(
                      siteRequestId: widget.siteRequestId,
                      mobileUsername: widget.mobileUsername,
                    );
                  }));
                }
                {
                  Fluttertoast.showToast(
                      msg: res.message!,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }

              if (idRepairValue == 0 ||
                  idSpareValue == 0 ||
                  selectedSpareCodes.isEmpty) {
                Fluttertoast.showToast(
                    msg: "برجاء اختيار البيانات المطلوبه",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: const Text("طلب"),
          )
        ],
      ),
    );
  }
}
