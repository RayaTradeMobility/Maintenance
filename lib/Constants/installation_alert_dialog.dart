import 'package:flutter/material.dart';

import '../Views/uploadImageInstallation.dart';
import 'Constants.dart';

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
                foregroundColor: Colors.white,
                backgroundColor: MyColorsSample.primary.withOpacity(0.8),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(4), bottom: Radius.circular(5)),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);

                showDialog(
                  builder: (context) {
                    return UploadImageButton(
                      siteRequestID: widget.requestId,
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
