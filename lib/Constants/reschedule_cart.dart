// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maintenance/Models/get_order_model.dart';
import 'package:table_calendar/table_calendar.dart';

import '../API/API.dart';
import '../Views/homeScreen.dart';
import 'Constants.dart';

class RescheduleCartItem extends StatefulWidget {
  const RescheduleCartItem(
      {super.key,
      required this.workOrderID,
      required this.mobileUsername,
      required this.siteRequestId});

  final String workOrderID, mobileUsername, siteRequestId;

  @override
  State<RescheduleCartItem> createState() => _RescheduleCartItemState();
}

DateTime _selectedDay = DateTime.now();
String _selectedDateString = '';
DateTime _focusedDay = DateTime.now();
API api = API();

class _RescheduleCartItemState extends State<RescheduleCartItem> {
  @override
  Widget build(BuildContext context) {
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
              _focusedDay = focusedDay;
              // Update _focusedDay if needed
            });
          },
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
          onPressed: () async {
            if (kDebugMode) {
              print('Selected Day : $_selectedDateString');
            }
            GetOrder res = await api.resceduleSpareCase(
                _selectedDateString, widget.workOrderID, widget.mobileUsername);
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
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
