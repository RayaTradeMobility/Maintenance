// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/Views/historyScreen.dart';
import 'package:maintenance/Views/orderScreen.dart';
import 'package:maintenance/Views/stockScreen.dart';
import 'package:maintenance/Views/visit_screen.dart';

import '../Constants/home_card.dart';

class HomePage extends StatefulWidget {
  final String siteRequestId, mobileUsername;

  const HomePage(
      {Key? key, required this.siteRequestId, required this.mobileUsername})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late String menuName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  // ignore: slash_for_doc_comments
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/raya.png',
                  width: 200,
                  height: 200,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
              ),

              // Center(
              //   child: SizedBox(
              //     width: 190,
              //     height: 190,
              //     child: HomeCart(
              //       image: 'assets/order.png',
              //       text: 'الطلبات',
              //       onPressed: () {
              //         if (kDebugMode) {
              //           print(widget.siteRequestId);
              //           print(widget.mobileUsername);
              //         }
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => OrderScreen(
              //                   mobileUsername: widget.mobileUsername,
              //                   siteRequestId: widget.siteRequestId)),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 30.0,
                  childAspectRatio: 1 / 1.35,
                  crossAxisCount: 2,
                  children: [
                    HomeCart(
                      image: 'assets/order.png',
                      text: 'الطلبات',
                      onPressed: () {
                        if (kDebugMode) {
                          print(widget.siteRequestId);
                          print(widget.mobileUsername);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                  mobileUsername: widget.mobileUsername,
                                  siteRequestId: widget.siteRequestId)),
                        );
                      },
                    ),
                    HomeCart(
                      image: 'assets/visiticon.png',
                      text: 'الزيارات',
                      onPressed: () {
                        if (kDebugMode) {
                          print(widget.siteRequestId);
                          print(widget.mobileUsername);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VisitScreen(
                                    mobileUsername: widget.mobileUsername,
                                    siteRequestId: widget.siteRequestId,
                                  )),
                        );
                      },
                    ),
                    HomeCart(
                      image: 'assets/history.png',
                      text: 'السجل',
                      onPressed: () {
                        if (kDebugMode) {
                          print(widget.siteRequestId);
                          print(widget.mobileUsername);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryScreen(
                              siteRequestID: widget.siteRequestId,
                              mobileUsername: widget.mobileUsername,
                            ),
                          ),
                        );
                      },
                      // ignore: unrelated_type_equality_checks
                    ),
                    HomeCart(
                      image: 'assets/stockbox.png',
                      text: 'المخزن',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StockScreen(
                                    siteRequestID: widget.siteRequestId,
                                  )),
                        );
                      },
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
