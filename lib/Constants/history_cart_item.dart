import 'package:flutter/material.dart';

import 'Constants.dart';

class HistoryCart extends StatelessWidget {
  final String workOrderID;
  final String workStatus;
  final String maintenanceAmount;
  final String maintenanceFinishTime;

  const HistoryCart(this.workOrderID, this.workStatus, this.maintenanceAmount,
      this.maintenanceFinishTime,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: MyColorsSample.primaryDark.withOpacity(0.5),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/icon.png", height: 30, width: 30),
                  Container(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 5),
                        Text(
                          "Work Order ID: $workOrderID",
                          style: MyTextSample.button(context)!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                        Container(height: 10),
                        Text(
                          "Work Status: ${workStatus.toLowerCase()}",
                          style: MyTextSample.body1(context)!.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12),
                        ),
                        Container(height: 10),
                        Text(
                          "Maintenance Amount: $maintenanceAmount",
                          maxLines: 2,
                          style: MyTextSample.subhead(context)!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                        Container(height: 10),
                        Text(
                          "Maintenance Total Amount: $maintenanceFinishTime",
                          maxLines: 2,
                          style: MyTextSample.subhead(context)!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
