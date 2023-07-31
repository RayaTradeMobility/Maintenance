
import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/historyModel.dart';
// ignore: depend_on_referenced_packages

class HistoryScreen extends StatefulWidget {
  final String siteRequestId;

  const HistoryScreen({
    Key? key, required this.siteRequestId,

  }) : super(key: key);

  @override
  HistoryScreenState createState() => HistoryScreenState();
}
class HistoryScreenState extends State<HistoryScreen> {
  late Future<HistoryModel> _futureData;

  API api = API();
  @override
  void initState() {
    super.initState();
    _futureData = api.fetchHistory(widget.siteRequestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(59, 60, 54,20),
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
                  "اجمالي الصيانه اليوم : ${historyModel!
                      .sumMaintenanceAmount}" ,
                  style: const TextStyle(fontStyle:FontStyle.normal ,
                  color: Colors.black , fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: historyModel!.orders!.length,
              itemBuilder: (context, index) {
                final order = historyModel.orders![index];
                return Card(
                  child: productCard(
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
    }
            else  if (snapshot.hasError){
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
            }
            else{
              return Center(child: Column(
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
                      color: Colors.red,
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

  Widget productCard(String workOrderID, workStatus, maintenanceAmount, maintenanceFinishTime) {
    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 10.0,
      child: SizedBox(
        height: 120.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Work Order ID: ${workOrderID.trim()} ',
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Work Status: ${workStatus.trim()}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),),
                  Text(
                    'Maintenance Amount: ${maintenanceAmount.trim()}',
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Maintenance Finish Time: ${maintenanceFinishTime.trim()} ',
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}