// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Views/homeScreen.dart';
import '../Constants/Constants.dart';

class UploadImageButton extends StatefulWidget {
  final Function(List<File>)? onImageSelected;
  final String requestID, mobileUsername, serialIn, serialOut, comment;

  const UploadImageButton(
      {Key? key,
      this.onImageSelected,
      required this.requestID,
      required this.mobileUsername,
      required this.serialIn,
      required this.serialOut,
      required this.comment})
      : super(key: key);

  @override
  UploadImageButtonState createState() => UploadImageButtonState();
}

class UploadImageButtonState extends State<UploadImageButton> {
  final picker = ImagePicker();
  final List<File> _pickedFiles = [];
  API api = API();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (_pickedFiles.length < 3) {
          _pickedFiles.add(File(pickedFile.path));
        } else {
          Fluttertoast.showToast(
            msg: "  لا يمكن ارسال اكثر من  3 صور",
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
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.camera),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: MyColorsSample.primary.withOpacity(0.9),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4), bottom: Radius.circular(5)),
              ),
            ),
            child: const Text('من الكاميرا'),
          ),
          const SizedBox(
            width: 100,
          ),
          ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: MyColorsSample.primary.withOpacity(0.9),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4), bottom: Radius.circular(5)),
                ),
              ),
              child: const Text("من الاستوديو")),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 5,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.backspace_outlined),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: MyColorsSample.black.withOpacity(0.7),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(4), bottom: Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    if (kDebugMode) {
                      print(widget.requestID);
                      print(widget.mobileUsername);
                      print(widget.serialIn);
                      print(widget.serialOut);
                      print(widget.comment);
                    }
                    api.getInstallationCase(
                      widget.requestID,
                      widget.mobileUsername,
                      widget.serialIn,
                      widget.serialOut,
                      widget.comment,
                      _pickedFiles.map((file) => file.path).toList(),
                    );
                    showDialog(
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(
                                        siteRequestId: '',
                                        mobileUsername: widget.mobileUsername,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Done"))
                          ],
                        );
                      },
                      context: context,
                    );
                  },
                  child: const Text(' ارسال الطلب'),
                ),
              ],
            ),
            if (_pickedFiles.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _pickedFiles.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Image.file(
                              _pickedFiles[index],
                              fit: BoxFit.cover,
                              height: 170,
                              width: 170,
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: GestureDetector(
                                onTap: () => _deleteImage(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              )
            else
              Container(
                height: 600.0,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
