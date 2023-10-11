import 'package:flutter/material.dart';

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
