// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maintenance/Models/get_order_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../API/API.dart';
import '../Views/homeScreen.dart';
import 'Constants.dart';

class VisitAction extends StatefulWidget {
  const VisitAction(
      {super.key,
      required this.requestId,
      required this.mobileUsername,
      required this.siteRequestId});

  final String requestId, mobileUsername, siteRequestId;

  @override
  State<VisitAction> createState() => _VisitActionState();
}

DateTime _selectedDay = DateTime.now();
String _selectedDateString = '';
DateTime _focusedDay = DateTime.now();
API api = API();
TextEditingController commentController = TextEditingController();
String? techStatus;
List<String> status = [
  "Repair Completed",
  "Customer Reschedule",
  "Tech Reschedule",
  "Cancelled"
];

class _VisitActionState extends State<VisitAction> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: techStatus == "Customer Reschedule"
          ? SizedBox(
              width: 300,
              height: 400,
              child: SingleChildScrollView(
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
                      _focusedDay = focusedDay;
                    });
                  },
                ),
              ),
            )
          : const SizedBox(
              height: 100,
            ),
      actions: [
        Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 235, 231, 231),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton(
            isDense: true,
            borderRadius: BorderRadius.circular(10),
            dropdownColor: const Color.fromARGB(255, 239, 241, 241),
            underline: const SizedBox(),
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            isExpanded: true,
            value: techStatus,
            items: status
                .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                techStatus = value!;
              });
            },
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        SingleChildScrollView(
          child: TextField(
            controller: commentController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Write Comment",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.blue))),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                if (commentController.text.isNotEmpty) {
                  GetOrder res = await api.getVisitAction(
                      widget.requestId,
                      _selectedDateString,
                      techStatus!,
                      widget.mobileUsername,
                      commentController.text);
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
                    commentController.clear();
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
                } else {
                  Fluttertoast.showToast(
                      msg: "Please Write Comment",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text('Done'),
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
                if (kDebugMode) {
                  print('Selected Day : $_selectedDateString');
                  print('focused Day : $_focusedDay');
                }
                Navigator.pop(context);
                commentController.clear();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ],
    );
  }
}
