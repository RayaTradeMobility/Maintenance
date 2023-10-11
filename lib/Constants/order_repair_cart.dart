// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../Views/repairScreen.dart';

class CustomCardRepair extends StatelessWidget {
  final String customerName,
      mobile_Number,
      work_Order_ID,
      primary_Serial_Number,
      product_Model,
      brand,
      siteRequestId;

  const CustomCardRepair({
    Key? key,
    required this.customerName,
    required this.mobile_Number,
    required this.work_Order_ID,
    required this.primary_Serial_Number,
    required this.product_Model,
    required this.brand,
    required this.siteRequestId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RepairScreen(
                  workOrderId: work_Order_ID, siteRequestId: siteRequestId)),
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${customerName.replaceAll("\n", " ")} : الاسم ',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 7.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$mobile_Number :رقم الموبايل',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.mobile_friendly,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 7.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$primary_Serial_Number :السريال',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.code,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 7.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$work_Order_ID :رقم العامل',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.credit_card_outlined,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 7.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$product_Model :المنتج',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.category,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 7.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$brand :المركه',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.branding_watermark,
                      color: Colors.grey,
                    ),
                  ]),
            ],
          )),
    );
  }
}
