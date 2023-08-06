// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/historyModel.dart';

import '../Constants/Constants.dart';

class HistoryScreen extends StatefulWidget {
  final String mobileUsername;

  const HistoryScreen({Key? key, required this.mobileUsername})
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
    _futureData = api.fetchHistory(widget.mobileUsername);
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
          if (snapshot.hasData) {
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
                        child: CustomerCard(
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

class CustomerCard extends StatelessWidget {
  final String workOrderID;
  final String workStatus;
  final String maintenanceAmount;
  final String maintenanceFinishTime;
  const CustomerCard(this.workOrderID, this.workStatus, this.maintenanceAmount,
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
