// ignore_for_file: file_names, use_build_context_synchronously
import 'package:collapsible/collapsible.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../API/API.dart';
import '../Constants/Constants.dart';
import '../Constants/installation_alert_dialog.dart';
import '../Models/get_order_model.dart';
import 'homeScreen.dart';

class InstallationScreen extends StatefulWidget {
  final String mobileUsername,
      customerName,
      mobileNumber,
      city,
      address,
      symptom,
      model,
      serial,
      category,
      brand,
      symptomCategory,
      requestID,
      siteRequestId;

  const InstallationScreen(
      {Key? key,
      required this.mobileUsername,
      required this.customerName,
      required this.mobileNumber,
      required this.city,
      required this.address,
      required this.symptom,
      required this.model,
      required this.serial,
      required this.category,
      required this.brand,
      required this.symptomCategory,
      required this.requestID,
      required this.siteRequestId})
      : super(key: key);

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen>
    with SingleTickerProviderStateMixin {
  Widget customSearchBar = const Text("التركيب");

  API api = API();
  bool _collapse = false, collapse = false;
  TextEditingController commentController = TextEditingController();
  TextEditingController commentForCancelController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogPage(
                      requestId: widget.requestID,
                      mobileUsername: widget.mobileUsername,
                    );
                  });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: MyColorsSample.primary.withOpacity(0.8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4), bottom: Radius.circular(5)),
              ),
            ),
            child: const Text('طلب'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: MyColorsSample.primary.withOpacity(0.8),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4), bottom: Radius.circular(5)),
              ),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Cancel Spare'),
                    content: TextField(
                      controller: commentForCancelController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your comment',
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              MyColorsSample.primary.withOpacity(0.8),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(4),
                                bottom: Radius.circular(5)),
                          ),
                        ),
                        onPressed: () async {
                          if (kDebugMode) {
                            // print(widget.workOrderID);
                            print(widget.mobileUsername);
                            print(commentController.text);
                          }
                          GetOrder res = await api.cancelSpareCaseInstallation(
                              commentForCancelController.text,
                              "widget.workOrderID",
                              widget.mobileUsername);

                          if (res.message == "Success") {
                            Fluttertoast.showToast(
                                msg: "${res.message}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  siteRequestId: widget.siteRequestId,
                                  mobileUsername: widget.mobileUsername,
                                ),
                              ),
                              (route) => false,
                            );
                          }
                          if (res.message != "Success") {
                            Fluttertoast.showToast(
                                msg: res.message ?? "Something Went Wrong",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        title: customSearchBar,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Card(
                elevation: 5.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'بيانات العميل ',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (_collapse == true) {
                                    _collapse = false;
                                  } else {
                                    _collapse = true;
                                  }
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down))
                        ],
                      ),
                      const Divider(
                        thickness: 0.8,
                        color: Color(0xFF3f8dfd),
                      ),
                      Collapsible(
                        collapsed: _collapse,
                        axis: CollapsibleAxis.vertical,
                        minOpacity: 0.2,
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${widget.customerName.split(' ').first} :الاسم الاول ",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${widget.customerName.split(' ').last} :الاسم الاخير ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(
                                  Icons.account_box_rounded,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${widget.mobileNumber} :رقم الموبايل ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(
                                  Icons.phone_android,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${widget.city} :المدينه ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Icon(
                                  Icons.mobile_friendly,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: const BoxConstraints(
                                        minWidth: 100, maxWidth: 200),
                                    child: Text(
                                      widget.address.trim(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Text(
                                    ': العنوان',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                ]),
                            const SizedBox(
                              height: 5.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'البيانات',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (collapse == true) {
                                    collapse = false;
                                  } else {
                                    collapse = true;
                                  }
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down))
                        ],
                      ),
                      const Divider(
                        thickness: 0.8,
                        color: Color(0xFF3f8dfd),
                      ),
                      Collapsible(
                        collapsed: collapse,
                        axis: CollapsibleAxis.vertical,
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${widget.serial}:السريال ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  ':القسم ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${widget.category}:المركه ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${widget.brand}  :المنتج ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.symptom,
                                      maxLines: 12,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const Text(
                                    ': المشكله ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${widget.symptomCategory} :نوع المشكله ',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${widget.requestID} :رقم الطلب',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
