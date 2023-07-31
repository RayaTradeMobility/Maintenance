import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/stockModel.dart';

import '../Constants/Constants.dart';

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
            backgroundColor: MyColorsSample.primary.withOpacity(0.8)    ,
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
                        child: CustomerCard(
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
  final String partNumber;
  final String spareDescription;
  final String currentQty;
  const CustomerCard( this.partNumber, this.spareDescription, this.currentQty , {super.key,
  });

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
                Image.asset(
                  "assets/card.png",height: 50, width: 50),
                Container(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 5),
                      Text(
                        "Part Number: $partNumber" ,
                        style: MyTextSample.button(context)!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Container(height: 10),
                      Text(
                        "Spare Description: ${spareDescription.toLowerCase()}",
                        style: MyTextSample.body1(context)!.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      Container(height: 10),
                      Text(
                        "Current Quantity: $currentQty",
                        maxLines: 2,
                        style: MyTextSample.subhead(context)!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
      }
}

