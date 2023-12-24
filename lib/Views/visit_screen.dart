import 'package:flutter/material.dart';
import 'package:maintenance/Constants/visit_action_alert.dart';
import 'package:maintenance/Constants/visit_cart_item.dart';
import 'package:shimmer/shimmer.dart';

import '../API/API.dart';
import '../Constants/Constants.dart';
import '../Models/visit_model.dart';

class VisitScreen extends StatefulWidget {
  const VisitScreen(
      {super.key, required this.mobileUsername, required this.siteRequestId});

  final String mobileUsername, siteRequestId;

  @override
  State<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen> {
  late Future<VisitModel> _futureData;
  API api = API();

  @override
  void initState() {
    super.initState();
    _futureData = api.getVisit(widget.mobileUsername);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الزيارات"),
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        shadowColor: Colors.black,
        centerTitle: true,
      ),
      body: FutureBuilder<VisitModel>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 22,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0,
                    childAspectRatio: 3 / 1,
                    crossAxisCount: 1,
                    children: List.generate(
                      5,
                      (index) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 7.4,
                              child: Card(
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Container(),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
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
            );
          }

          if (snapshot.hasData && snapshot.data!.code == '00') {
            final visitModel = snapshot.data;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: visitModel!.techVisits!.length,
                    itemBuilder: (context, index) {
                      final order = visitModel.techVisits![index];
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return VisitAction(
                                  requestId: order.requestID!,
                                  mobileUsername: widget.mobileUsername,
                                  siteRequestId: widget.siteRequestId,
                                );
                              });
                        },
                        child: Card(
                          child: VisitCart(
                            customerName: order.customerName!,
                            mobile: order.customerMobile!,
                            priority: order.priority!,
                            requestId: order.requestID!,
                            address: order.address!,
                            symptom: order.symptom!,
                            model: order.model!,
                            gspn: order.gspn!,
                            serialNumber: order.serialNumber!,
                            spareParts: order.spareParts!,
                            warrantyStatus: order.warrantyStatus!,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData &&
              snapshot.data!.code == '10' &&
              snapshot.data!.message == "There is no Visits") {
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: Center(child: Text("${snapshot.data!.message}")),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/nohistory.png',
                    width: 130,
                    height: 130,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    ' يوجد خطا في البانات',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/nohistory.png',
                    width: 130,
                    height: 130,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    ' جاري تحميل البيانات',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.manage_history,
                size: 120,
              ),
              const SizedBox(
                height: 12,
              ),
              Text("${snapshot.data!.message}"),
            ],
          ));
        },
      ),
    );
  }
}
