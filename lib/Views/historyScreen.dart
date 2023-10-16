// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/historyModel.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants/Constants.dart';
import '../Constants/history_cart_item.dart';

class HistoryScreen extends StatefulWidget {
  final String siteRequestID, mobileUsername;

  const HistoryScreen({Key? key, required this.siteRequestID, required this.mobileUsername})
      : super(key: key);

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  late Future<HistoryModel> _futureData;
  API api = API();

  @override
  void initState() {
    super.initState();
    _futureData = api.fetchHistory(widget.siteRequestID ,widget.mobileUsername);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      appBar: AppBar(
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        shadowColor: Colors.black,
        title: const Text("السجل"),
        centerTitle: true,
      ),
      body: FutureBuilder<HistoryModel>(
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

          if (snapshot.hasData && snapshot.data!.headerInfo!.code == '00') {
            final historyModel = snapshot.data;
            return Column(
              children: [
                SizedBox(
                  height: 25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "اجمالي الصيانه اليوم : ${historyModel!.sumMaintenanceAmount} جنيه",
                        style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: historyModel.orders!.length,
                    itemBuilder: (context, index) {
                      final order = historyModel.orders![index];
                      return Card(
                        child: HistoryCart(
                          order.workOrderID!,
                          order.workStatus!,
                          order.maintenanceAmount!,
                          order.maintenanceFinishTime!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData &&
              snapshot.data!.headerInfo!.code == '10' &&
              snapshot.data!.headerInfo!.message ==
                  "There is No Orders Available") {
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child:
                  Center(child: Text("${snapshot.data!.headerInfo!.message}")),
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
              Text("${snapshot.data!.headerInfo!.message}"),
            ],
          ));
        },
      ),
    );
  }
}
