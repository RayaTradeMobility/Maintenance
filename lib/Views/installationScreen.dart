// ignore_for_file: file_names
import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/Views/uploadImageInstallation.dart';

import '../Constants/Constants.dart';

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
      requestID;

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
      required this.requestID})
      : super(key: key);

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen>
    with SingleTickerProviderStateMixin {
  Widget customSearchBar = const Text("التركيب");

  bool _collapse = false, collapse = false;
  TextEditingController commentController = TextEditingController();

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
                foregroundColor: Colors.white, backgroundColor: MyColorsSample.primary.withOpacity(0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top : Radius.circular(4) , bottom: Radius.circular(5)),
      ),),
            child: const Text('طلب'),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical( bottom: Radius.circular(15)),
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
                            // const Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     Text(
                            //       ':المنطقه ',
                            //       style: TextStyle(
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //     Icon(
                            //       Icons.location_city,
                            //       color: Colors.grey,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.address,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
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
                                  '${widget.brand} :المنتج ',
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
                                          fontSize: 13)),
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

class AlertDialogPage extends StatefulWidget {
  final String requestId, mobileUsername;

  const AlertDialogPage(
      {super.key, required this.requestId, required this.mobileUsername});

  @override
  AlertDialogPageState createState() => AlertDialogPageState();
}

class AlertDialogPageState extends State<AlertDialogPage> {
  TextEditingController indoorController = TextEditingController();
  TextEditingController outdoorController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  get filePicker => null;

  @override
  void dispose() {
    indoorController.dispose();
    outdoorController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('طلب')),
      icon: InkWell(
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: Colors.black,
              ))),
      iconPadding: const EdgeInsets.only(left: 220, top: 20),
      // icon: const Icon(Icons.close , color: Colors.red),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: indoorController,
            decoration: const InputDecoration(
              hintText: 'السريال الداخلي',
            ),
          ),
          TextField(
            controller: outdoorController,
            decoration: const InputDecoration(
              hintText: 'السريال الخارجي',
            ),
          ),
          TextField(
            controller: commentController,
            decoration: const InputDecoration(
              hintText: 'ملاحظه',
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: MyColorsSample.primary.withOpacity(0.8),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top : Radius.circular(4) , bottom: Radius.circular(5)),
                ),),
              onPressed: () {
                showDialog(
                  builder: (context) {
                    return UploadImageButton(
                      requestID: widget.requestId,
                      mobileUsername: widget.mobileUsername,
                      serialIn: indoorController.text,
                      serialOut: outdoorController.text,
                      comment: commentController.text,
                    );
                  },
                  context: context,
                );
              },
              child: const Text('تحميل الصور'),
            ),
          ])
        ],
      ),
    );
  }
}
