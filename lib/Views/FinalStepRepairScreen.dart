// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maintenance/Constants/reschedule_cart.dart';
import 'package:maintenance/Models/getSparesOnCaseModel.dart';
import 'package:maintenance/Models/get_order_model.dart';
import 'package:maintenance/Views/homeScreen.dart';
import 'package:maintenance/Views/repairScreen.dart';

import '../API/API.dart';
import '../Constants/Constants.dart';
import '../Constants/spare_case_cart.dart';

class FinalStepRepairScreen extends StatefulWidget {
  const FinalStepRepairScreen(
      {Key? key,
      required this.workOrderID,
      required this.mobileUsername,
      required this.siteRequestId,
      required this.maintenanceRID})
      : super(key: key);

  final String workOrderID, mobileUsername, siteRequestId;
  final String maintenanceRID;

  @override
  State<FinalStepRepairScreen> createState() => _FinalStepRepairScreenState();
}

class _FinalStepRepairScreenState extends State<FinalStepRepairScreen> {
  List<Spares> spareOnCase = [];
  API api = API();

  Future<void> fetchSparesCases() async {
    GetSparesOnCase fetchSpareCase =
        await api.fetchSparesCases(widget.workOrderID, widget.mobileUsername);
    setState(() {
      spareOnCase = fetchSpareCase.spares!;
    });
  }

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSparesCases();
  }

  Future<bool> onWillPop() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => RepairScreen(
          siteRequestId: widget.siteRequestId,
          mobileUsername: widget.mobileUsername,
          workOrderId: widget.workOrderID,
          maintenanceRID: widget.maintenanceRID,
        ),
      ),
      (route) => false,
    );

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            onPressed: () {
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
                            print(widget.workOrderID);
                            print(widget.mobileUsername);
                            print(commentController.text);
                          }
                          GetOrder res = await api.cancelSpareCase(
                              commentController.text,
                              widget.workOrderID,
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
            child: const Text('Cancel'),
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
            onPressed: () {
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
                              widget.workOrderID,
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
            child: const Text('Finish'),
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return RescheduleCartItem(
                      workOrderID: widget.workOrderID,
                      mobileUsername: widget.mobileUsername,
                      siteRequestId: widget.siteRequestId);
                },
              );
            },
            child: const Text('ReSchedule'),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        title: const Text("Spare Cases"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: spareOnCase.length,
                itemBuilder: (BuildContext context, int index) {
                  final Spares stocks = spareOnCase[index];

                  return Card(
                    color: const Color.fromRGBO(229, 228, 226, 20),
                    child: Center(
                      child: ItemCardSpareCases(
                        spareRID: stocks.spareRID!,
                        spareCode: stocks.spareCode!,
                        requestID: stocks.requestID!,
                        submitter: stocks.submitter!,
                        sparePrice: stocks.sparePrice!,
                        createDate: stocks.createDate!,
                        partReplaced: stocks.partReplaced!,
                        siteRequestId: widget.siteRequestId,
                        workOrderId: widget.workOrderID,
                        mobileUsername: widget.mobileUsername,
                        maintenanceRID: widget.maintenanceRID,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
