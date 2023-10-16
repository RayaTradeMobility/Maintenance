// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/Models/getSparesOnCaseModel.dart';
import 'package:table_calendar/table_calendar.dart';

import '../API/API.dart';
import '../Constants/Constants.dart';
import '../Constants/spare_case_cart.dart';

class FinalStepRepairScreen extends StatefulWidget {
  const FinalStepRepairScreen(
      {Key? key,
      required this.workOrderID,
      required this.mobileUsername,
      required this.siteRequestId})
      : super(key: key);

  final String workOrderID, mobileUsername, siteRequestId;

  @override
  State<FinalStepRepairScreen> createState() => _FinalStepRepairScreenState();
}

class _FinalStepRepairScreenState extends State<FinalStepRepairScreen> {
  DateTime _selectedDay = DateTime.now();
  String _selectedDateString = '';

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
                          backgroundColor: MyColorsSample.primary.withOpacity(0.8),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(4), bottom: Radius.circular(5)),
                          ),
                        ),

                        onPressed: ()async {
                          await api.cancelSpareCase(commentController.text, widget.workOrderID, widget.mobileUsername);

                          Navigator.pop(context); // Close the dialog
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
                          backgroundColor: MyColorsSample.primary.withOpacity(0.8),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(4), bottom: Radius.circular(5)),
                          ),
                        ),

                        onPressed: ()async {
                          await api.finishSpareCase(commentController.text, widget.workOrderID, widget.mobileUsername);

                          Navigator.pop(context); // Close the dialog
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
                  return AlertDialog(
                    content: SizedBox(
                      width: 300,
                      height: 400,
                      child: TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        focusedDay: DateTime.now(),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _selectedDateString = selectedDay.toString();
                            // Update _focusedDay if needed
                          });
                        },
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print(_selectedDateString);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('Done'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print(_selectedDateString);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
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
      body: Column(
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
