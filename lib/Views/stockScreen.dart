import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/stockModel.dart';

class StockScreen extends StatefulWidget {
  final String siteRequestId;
  const StockScreen({Key? key, required this.siteRequestId}) : super(key: key);

  @override
  StockScreenState createState() => StockScreenState();
}

class StockScreenState extends State<StockScreen> {
   late Future<StockModel> _futureData;
  API api = API();

  @override
  void initState() {
    _futureData=  api.fetchStock(widget.siteRequestId);
    super.initState();

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
            title: const Text("المخزن"),
            centerTitle: true,
          ),
          body: FutureBuilder<StockModel>(
            future: _futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final stockModel = snapshot.data;
                return ListView.builder(
                  itemCount: stockModel!.stock!.length,
                  itemBuilder: (context, index) {
                    final stocking = stockModel.stock![index];

                    return Card(
                        child: productCard(
                            stocking.partNumber!,
                            stocking.spareDescription!,
                            stocking.currentQty!,
                      ),
                    );
                  },
                );
              }
              else  if (snapshot.hasError){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/blank.png',
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
                      'assets/blank.png',
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
}

Widget productCard(
    String partNumber,
    String spareDescription,
    String currentQty,
    ) {

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),

    ),
    color: Colors.white,shadowColor: Colors.black.withOpacity(0.2), clipBehavior: Clip.antiAliasWithSaveLayer,
surfaceTintColor: Colors.green,
    elevation: 54.0,
    child: SizedBox(
      height: 85.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Part Number: ${partNumber.trim()} ',
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Spare Description: ${spareDescription.trim()}',
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Current Quantity: ${currentQty.trim()}',
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}