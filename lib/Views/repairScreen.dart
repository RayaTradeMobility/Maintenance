// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/getRecommendationRepairModel.dart';
import 'package:maintenance/Views/FinalStepRepairScreen.dart';
import 'package:shimmer/shimmer.dart';
import '../Constants/Constants.dart';
import '../Constants/Repair_cart_item.dart';
import '../Constants/reschedule_cart.dart';
import '../Models/get_order_model.dart';
import 'homeScreen.dart';

class RepairScreen extends StatefulWidget {
  final String workOrderId, siteRequestId, mobileUsername, maintenanceRID;

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
  List<Spares> sparesList = [];
  bool _isLoading = false;
  TextEditingController searchController = TextEditingController();
  List<TextEditingController> controllers = [];
  List<Spares> filteredItemList = [];
  late List<Map<String, dynamic>> convertedList;
  List<dynamic> selectedSpareCodes = [];
  List<dynamic> filteredList = [];
  API api = API();
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRepairCases();
  }

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
      if (fetchedRecommendation.spares == null) {
        sparesList = [];
        _isLoading = true;
      } else if (fetchedRecommendation.spares != null) {
        sparesList = fetchedRecommendation.spares!;
        _isLoading = true;
      }
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
      floatingActionButton: SpeedDial(
          icon: Icons.add,
          backgroundColor: MyColorsSample.primary,
          children: [
            SpeedDialChild(
              child:
                  const Icon(Icons.schedule_send_outlined, color: Colors.white),
              label: 'Reschedule Case',
              backgroundColor: MyColorsSample.primary,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return RescheduleCartItem(
                        workOrderID: widget.workOrderId,
                        mobileUsername: widget.mobileUsername,
                        siteRequestId: widget.siteRequestId);
                  },
                );
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              label: 'Cancel Case',
              backgroundColor: MyColorsSample.primary,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Cancel Spare'),
                      content: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your comment',
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                MyColorsSample.primary.withOpacity(0.8),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(4),
                                  bottom: Radius.circular(5)),
                            ),
                          ),
                          onPressed: () async {
                            if (kDebugMode) {
                              print(widget.workOrderId);
                              print(widget.mobileUsername);
                              print(commentController.text);
                            }
                            GetOrder res = await api.cancelSpareCaseRepair(
                                commentController.text,
                                widget.workOrderId,
                                widget.mobileUsername);

                            if (res.message == "Success") {
                              Fluttertoast.showToast(
                                  msg: "${res.message}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    siteRequestId: widget.siteRequestId,
                                    mobileUsername: widget.mobileUsername,
                                  ),
                                ),
                                (route) => false,
                              );
                            }
                            if (res.message != "Success") {
                              Fluttertoast.showToast(
                                  msg: res.message ?? "Something Went Wrong",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.done, color: Colors.white),
              label: 'Finish Case',
              backgroundColor: MyColorsSample.primary,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Finish Spare'),
                      content: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your comment',
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                MyColorsSample.primary.withOpacity(0.8),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(4),
                                  bottom: Radius.circular(5)),
                            ),
                          ),
                          onPressed: () async {
                            GetOrder res = await api.finishSpareCase(
                                commentController.text,
                                widget.workOrderId,
                                widget.mobileUsername);

                            if (res.message == "Success") {
                              Fluttertoast.showToast(
                                  msg: "${res.message}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    siteRequestId: widget.siteRequestId,
                                    mobileUsername: widget.mobileUsername,
                                  ),
                                ),
                                (route) => false,
                              );
                            }
                            if (res.message != "Success") {
                              Fluttertoast.showToast(
                                  msg: res.message ?? "Something Went Wrong",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ]),
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
          Expanded(
            child: _isLoading == false
                ? Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 42,
                        ),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        7.4,
                                    child: Card(
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Container(),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4,
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
                  )
                : sparesList.isEmpty && _isLoading == true
                    ? Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/noresult.png',
                            ),
                            const Text(
                                'There is no Parts Available for this Case ')
                          ],
                        ),
                      )
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
                                isChecked: selectedSpareCodes
                                    .contains(spares.spareRID),
                                spareRID: spares.spareRID!,
                                onChecked: (List<dynamic> selectedDropDown) {
                                  toggleSpareCode(spares.spareRID!);

                                  selectedSpareCodes.add(selectedDropDown);
                                },
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      controllers.add(TextEditingController());

                                      return RepairCart(
                                        model: filteredItemList[index].model!,
                                        offering:
                                            filteredItemList[index].offering!,
                                        spareCode:
                                            filteredItemList[index].spareCode!,
                                        spareDescription:
                                            filteredItemList[index]
                                                .spareDescription!,
                                        ccTReference: filteredItemList[index]
                                            .ccTReference!,
                                        cost: filteredItemList[index].cost!,
                                        finalPrice:
                                            filteredItemList[index].finalPrice!,
                                        campaignFinalPrice:
                                            filteredItemList[index]
                                                .campaignFinalPrice!,
                                        serviceCode: filteredItemList[index]
                                            .serviceCode!,
                                        serviceLevel: filteredItemList[index]
                                            .serviceLevel!,
                                        repairModule: filteredItemList[index]
                                            .repairModule!,
                                        isChecked: selectedSpareCodes.contains(
                                            filteredItemList[index].spareRID),
                                        onChecked:
                                            (List<dynamic> selectedDropDown) {
                                          toggleSpareCode(
                                              filteredItemList[index]
                                                  .spareRID!);
                                          selectedSpareCodes
                                              .add(selectedDropDown);
                                        },
                                        spareRID:
                                            filteredItemList[index].spareRID!,
                                      );
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    filteredList =
                        selectedSpareCodes.whereType<List>().toList();
                    convertedList = filteredList.map((list) {
                      return {
                        'spare_RID': list[0].toString(),
                        'sparetype': list[1],
                        'repairIN': list[2],
                      };
                    }).toList();

                    print(convertedList);
                    print(filteredList);
                  }
                  if (convertedList.isNotEmpty) {
                    GetOrder res = await api.saveOrderOneBulk(
                        widget.workOrderId,
                        widget.siteRequestId,
                        convertedList,
                        widget.maintenanceRID,
                        widget.mobileUsername);
                    if (res.message!.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Please Wait",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    if (res.code == '00') {
                      Fluttertoast.showToast(
                          msg: res.message!,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FinalStepRepairScreen(
                                  workOrderID: widget.workOrderId,
                                  mobileUsername: widget.mobileUsername,
                                  siteRequestId: widget.siteRequestId,
                                  maintenanceRID: widget.maintenanceRID,
                                )),
                      );
                      convertedList.clear();
                      filteredList.clear();

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return FinalStepRepairScreen(
                          siteRequestId: widget.siteRequestId,
                          mobileUsername: widget.mobileUsername,
                          workOrderID: widget.workOrderId,
                          maintenanceRID: widget.maintenanceRID,
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

                  if (selectedSpareCodes.isEmpty) {
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
                child: const Text("ِAdd Spare"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
