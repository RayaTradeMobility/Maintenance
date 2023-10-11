// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/historyModel.dart';

import '../Constants/Constants.dart';
import '../Constants/history_cart_item.dart';

class HistoryScreen extends StatefulWidget {
  final String siteRequestID;

  const HistoryScreen({Key? key, required this.siteRequestID})
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
    _futureData = api.fetchHistory(widget.siteRequestID);
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
        },
      ),
    );
  }
}
