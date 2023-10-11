// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RepairCart extends StatefulWidget {
  final String model,
      offering,
      spareCode,
      spareDescription,
      ccTReference,
      cost,
      finalPrice,
      campaignFinalPrice,
      serviceCode,
      serviceLevel,
      repairModule;
  final bool isChecked;
  final VoidCallback onChecked;

  const RepairCart({
    Key? key,
    required this.model,
    required this.offering,
    required this.spareCode,
    required this.spareDescription,
    required this.ccTReference,
    required this.cost,
    required this.finalPrice,
    required this.campaignFinalPrice,
    required this.serviceCode,
    required this.serviceLevel,
    required this.repairModule,
    required this.isChecked,
    required this.onChecked,
  }) : super(key: key);

  @override
  State<RepairCart> createState() => _RepairCartState();
}

class _RepairCartState extends State<RepairCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.model} :الموديل ',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                width: 5.0,
              ),
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.spareCode} :كود القطعة ',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                width: 5.0,
              ),
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.spareDescription,
                  maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.end,
                  style:
                      const TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                const Text(" :وصف القطعه  "),
              ]),
          const SizedBox(
            height: 9.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${widget.finalPrice} :السعر النهائي ',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                width: 5.0,
              ),
            ],
          ),
          Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Checkbox(
              value: widget.isChecked,
              onChanged: (value) {
                widget.onChecked();
              },
            ),
            const Text(":اختيار  ")
          ]))
        ],
      ),
    );
  }
}
