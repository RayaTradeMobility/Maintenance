// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maintenance/Views/historyScreen.dart';
import 'package:maintenance/Views/orderScreen.dart';
import 'package:maintenance/Views/stockScreen.dart';

class HomePage extends StatefulWidget {
  final String siteRequestId , mobileUsername;

  const HomePage({Key? key,required this.siteRequestId , required this.mobileUsername}) : super(key: key);

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
              Center(
                child: SizedBox(
                  width: 190,
                  height: 190,
                  child: CustomCard(
                    image: 'assets/order.png',
                    text: 'الطلبات',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  OrderScreen(mobileUsername: widget.mobileUsername, siteRequestId : widget.siteRequestId)),
                      );
                    },
                  ),
                ),
              ),
              GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 30.0,
                  childAspectRatio: 1 / 1.35,
                  crossAxisCount: 2,
                  children: [
                    CustomCard(
                      image: 'assets/history.png',
                      text: 'السجل',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryScreen(
                              siteRequestID: widget.siteRequestId,
                            ),
                          ),
                        );
                      },
                      // ignore: unrelated_type_equality_checks
                    ),
                    CustomCard(
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

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.image,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String image;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shadowColor: Colors.grey,
      color: Colors.white.withOpacity(0.7),
      elevation: 19.0,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
