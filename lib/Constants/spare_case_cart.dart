// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/Views/FinalStepRepairScreen.dart';

import '../API/API.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class ItemCardSpareCases extends StatelessWidget {
  final String requestID,
      submitter,
      createDate,
      spareCode,
      partReplaced,
      sparePrice,
      spareRID,
      siteRequestId,
      workOrderId,
      mobileUsername,
      maintenanceRID;

  const ItemCardSpareCases({
    super.key,
    required this.requestID,
    required this.submitter,
    required this.createDate,
    required this.spareCode,
    required this.partReplaced,
    required this.sparePrice,
    required this.spareRID,
    required this.siteRequestId,
    required this.workOrderId,
    required this.mobileUsername,
    required this.maintenanceRID,
  });

  @override
  Widget build(BuildContext context) {
    API api = API();

    double width = MediaQuery.of(context).size.width / 12;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.width / 14,
          top: MediaQuery.of(context).size.width / 21),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .79,
            height: MediaQuery.of(context).size.height / 3.8,
            child: SizedBox(
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(
                                  txt: "partReplaced : $partReplaced")),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: CustomText(txt: "submitter : $submitter")),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(txt: "spareCode : $spareCode")),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child:
                                  CustomText(txt: "spare Price : $sparePrice")),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(txt: "requestID : $requestID")),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child:
                                  CustomText(txt: "createDate : $createDate")),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomText(txt: "spare RID : $spareRID")),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Positioned(
            right: width * 4.8,
            top: 0,
            child: Center(
              child: SizedBox(
                  child: mobileUsername == submitter
                      ? InkWell(
                          child: const Icon(
                            Icons.delete_forever_outlined,
                            size: 33,
                            color: Colors.red,
                          ),
                          onTap: () async {
                            if (kDebugMode) {
                              print(mobileUsername);
                            }
                            await api.deleteSpareCase(requestID, siteRequestId,
                                spareRID, mobileUsername);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FinalStepRepairScreen(
                                        siteRequestId: siteRequestId,
                                        mobileUsername: mobileUsername,
                                        workOrderID: workOrderId,
                                        maintenanceRID: maintenanceRID,
                                      )),
                            );
                          },
                        )
                      : Container()),
            ),
          )
        ],
      ),
    );
  }
}
