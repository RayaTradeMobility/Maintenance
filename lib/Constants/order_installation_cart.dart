// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../Views/installationScreen.dart';

class CustomCardInstallation extends StatelessWidget {
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
      request_ID;

  const CustomCardInstallation(
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
      required this.request_ID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InstallationScreen(
                    mobileUsername: mobileUsername,
                    customerName: customerName,
                    mobileNumber: mobileNumber,
                    city: city,
                    address: address,
                    symptom: symptom,
                    model: model,
                    serial: serial,
                    category: category,
                    brand: brand,
                    symptomCategory: symptomCategory,
                    requestID: request_ID,
                  )),
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
                      '$customerName :الاسم ',
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
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$mobileNumber :رقم الموبايل',
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
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$city :المدينه',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.location_city,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      address,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Text(
                      ' :العنوان',
                      style: TextStyle(color: Colors.black),
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
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$model :المنتج',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.branding_watermark_outlined,
                      color: Colors.grey,
                    ),
                  ]),
              const SizedBox(
                height: 9.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      symptom,
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(" :العطل"),
                    const Icon(
                      Icons.tire_repair,
                      color: Colors.grey,
                    ),
                  ]),
            ],
          )),
    );
  }
}
