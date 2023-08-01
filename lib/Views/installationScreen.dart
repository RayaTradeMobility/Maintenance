// ignore_for_file: file_names

import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InstallationScreen extends StatefulWidget {
  const InstallationScreen({Key? key}) : super(key: key);

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
                    return const AlertDialogPage();
                  });
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.grey),
            child: const Text('طلب'),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(59, 60, 54, 20),
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
                        child: const Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ":الاسم الاول ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ':الاسم الاخير ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.account_box_rounded,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ':رقم الموبايل ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ':المدينه ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.mobile_friendly,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ':المنطقه ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.location_city,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ':العنوان',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(
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
                        child: const Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  ':السريال ',
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
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  ':المركه ',
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
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  ':المنتج ',
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
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  ':السريال الداخلي ',
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
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  ':السريال الخارجي ',
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
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  ':المشكله ',
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
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  ':نوع المشكله ',
                                  style: TextStyle(
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
  const AlertDialogPage({super.key});

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
              onPressed: () {
                showDialog(
                  builder: (context) {
                    return const UploadImageButton();
                  },
                  context: context,
                );
              },
              child: const Text('تحميل الصور'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  builder: (context) {
                    return const OTPAlertDialog();
                  },
                  context: context,
                );
              },
              child: const Text('ارسال الطلب'),
            ),
          ])
        ],
      ),
    );
  }
}

class UploadImageButton extends StatefulWidget {
  final Function(List<File>)? onImageSelected;

  const UploadImageButton({Key? key, this.onImageSelected}) : super(key: key);

  @override
  UploadImageButtonState createState() => UploadImageButtonState();
}

class UploadImageButtonState extends State<UploadImageButton> {
  final picker = ImagePicker();
  final List<File> _pickedFiles = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (_pickedFiles.length < 5) {
          _pickedFiles.add(File(pickedFile.path));
        } else {
          Fluttertoast.showToast(
            msg: "لا يمكن ارسال اكثر من 5 ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );
        }
      });
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(_pickedFiles);
      }
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _pickedFiles.removeAt(index);
    });
    if (widget.onImageSelected != null) {
      widget.onImageSelected!(_pickedFiles);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.camera),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white),
            child: const Text('من الكاميرا'),
          ),
          const SizedBox(
            width: 100,
          ),
          ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white),
              child: const Text("من الاستوديو")),
        ],
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 25,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.done),
                  ),
                ),
              ],
            ),
            if (_pickedFiles.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _pickedFiles.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Center(
                          child: Image.file(
                            _pickedFiles[index],
                            fit: BoxFit.contain,
                            height: 120,
                            width: 120,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _deleteImage(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            else
              Container(
                height: 500.0,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}

class OTPAlertDialog extends StatefulWidget {
  const OTPAlertDialog({Key? key}) : super(key: key);

  @override
  State<OTPAlertDialog> createState() => OTPAlertDialogState();
}

class OTPAlertDialogState extends State<OTPAlertDialog> {
  final oTP = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("برجاء ادخال رمز التحقق المرسل الي العميل"),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('رقم العميل :'),
              const Text("0112398274"),
              TextFormField(
                controller: oTP,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "OTP",
                    prefixIcon: const Icon(Icons.format_list_numbered),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                },
                child: const Text("ارسال"),
              )
            ],
          ),
        ));
  }
}
