// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/stockModel.dart';
import '../Constants/Constants.dart';
import '../Constants/stock_item_cart.dart';

class StockScreen extends StatefulWidget {
  final String siteRequestID;

  const StockScreen({Key? key, required this.siteRequestID}) : super(key: key);

  @override
  StockScreenState createState() => StockScreenState();
}

class StockScreenState extends State<StockScreen> {
  API api = API();
  List<Stock> stockList = [];
  bool _isLoading = false;

  TextEditingController searchController = TextEditingController();
  List<TextEditingController> controllers = [];

  Future<void> fetchStockCases() async {
    StockModel fetchStock = await api.fetchStock(widget.siteRequestID);
    setState(() {
      stockList = fetchStock.stock!;
      _isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStockCases();
  }

  List<Stock> filteredItemList = [];

  void filterCrop(value) {
    setState(() {
      filteredItemList = stockList
          .where(
              (e) => e.partNumber!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: MyColorsSample.primary.withOpacity(0.8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
          shadowColor: Colors.black,
          title: const Text("المخزن"),
          centerTitle: true,
        ),
        body: Column(children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search for Stock code",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.blue))),
            onChanged: (value) {
              filterCrop(value);
            },
          ),
          Expanded(
            child: _isLoading == false
                ? const Center(child: CircularProgressIndicator())
                : searchController.text.isEmpty
                    ? ListView.builder(
                        itemCount: stockList.length,
                        itemBuilder: (BuildContext context, int index) {
                          controllers.add(TextEditingController());

                          final Stock stocks = stockList[index];

                          return Card(
                            child: StockCart(
                              stocks.partNumber!,
                              stocks.spareDescription!,
                              stocks.currentQty!,
                            ),
                          );
                        },
                      )
                    : searchController.text.isNotEmpty &&
                            filteredItemList.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.search_off,
                                      size: 80,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        'No results found,\nPlease try different keyword',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : filteredItemList.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: filteredItemList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  controllers.add(TextEditingController());

                                  return Card(
                                    child: StockCart(
                                      filteredItemList[index].partNumber!,
                                      filteredItemList[index].spareDescription!,
                                      filteredItemList[index].currentQty!,
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child:
                                    CircularProgressIndicator(), // Show CircularProgressIndicator if no data is available yet
                              ),
          ),
        ]));
  }
}
