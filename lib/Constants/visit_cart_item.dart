import 'package:flutter/material.dart';

import 'Constants.dart';

class VisitCart extends StatelessWidget {
  final String customerName,
      mobile,
      priority,
      requestId,
      address,
      symptom,
      model,
      gspn;

  const VisitCart(
      {super.key,
      required this.customerName,
      required this.mobile,
      required this.priority,
      required this.requestId,
      required this.address,
      required this.symptom,
      required this.model,
      required this.gspn});

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
                        Container(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Customer Name: $customerName",
                              maxLines: 2,
                              style: MyTextSample.subhead(context)!
                                  .copyWith(color: Colors.white, fontSize: 12),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Priority: ",
                                  maxLines: 2,
                                  style: MyTextSample.subhead(context)!
                                      .copyWith(color: Colors.white, fontSize: 12),
                                ),
                                Text(
                                  priority,
                                  maxLines: 2,
                                  style: MyTextSample.subhead(context)!
                                      .copyWith(color: Colors.red, fontSize: 12),
                                ),

                              ],
                            ),
                          ],
                        ),
                        Container(height: 10),
                        Text(
                          "Mobile: $mobile",
                          maxLines: 2,
                          style: MyTextSample.subhead(context)!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                        Container(height: 5),
                        Text(
                          "Request ID: $requestId",
                          style: MyTextSample.button(context)!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                        Container(height: 10),
                        Text(
                          "Symptom: $symptom",
                          style: MyTextSample.body1(context)!.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12),
                        ),
                        Container(height: 10),
                        Text(
                          "Address: $address",
                          maxLines: 2,
                          style: MyTextSample.subhead(context)!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                        Container(height: 10),
                        Text(
                          "Model: $model",
                          maxLines: 2,
                          style: MyTextSample.subhead(context)!
                              .copyWith(color: Colors.white, fontSize: 12),
                        ),
                        Container(height: 10),
                        Text(
                          "GSPN: $gspn",
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
