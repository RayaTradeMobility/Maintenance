// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String txt;

  CustomText({
    Key? key,
    required this.txt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        txt,
        style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 54, 53, 53)),
      ),
    );
  }
}
