// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

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
      repairModule,
      spareRID;
  final bool isChecked;
  final Function(List<dynamic> selectedDropDown) onChecked; // Updated callback signature


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
    required this.spareRID,
  }) : super(key: key);

  @override
  State<RepairCart> createState() => _RepairCartState();
}

class _RepairCartState extends State<RepairCart> {

   late List<dynamic> selectedDropDown = [widget.spareRID];

  String repairInValue = '';
  int idRepairValue = -1;
  List<int> repairInID = [];
  List<String> repairIn = [""];

  String faultTypeValue = '';
  int idSpareValue = -1;
  List<int> spareTypeID = [];
  List<String> spareCodeName = [""];

  @override
  void initState() {
    super.initState();
    _loadData();
  }


  Future<void> _loadData() async {
    await fetchSpareCodeType();
    // await fetchFaultCode();
    await fetchRepairIn();
    if (kDebugMode) {
      print('Calling');
    }
  }

  Future<void> fetchSpareCodeType() async {
    try {
      final response = await http.get(Uri.parse(
          'http://www.rayatrade.com/TechnicionMobileApi//api/User/GetSpareCodeType'));
      final data = json.decode(response.body);
      final spareType = data['spareTypes'];
      for (var e in spareType) {
        spareTypeID.add(e['id']);
        spareCodeName.add(e['name']);
      }
      setState(() {});
    } catch (error) {
      // Handle error here
      if (kDebugMode) {
        print('Error fetching spareCodeType: $error');
      }
    }
  }

  Future<void> fetchRepairIn() async {
    try {
      final response = await http.get(Uri.parse(
          'http://www.rayatrade.com/TechnicionMobileApi/api/User/GetRepairIN'));
      final data = json.decode(response.body);

      final repairType = data['repairINs'];

      for (var e in repairType) {
        repairIn.add(e['name']);
        repairInID.add(e['id']);
      }

      setState(() {});
      // ignore: empty_catches
    } catch (error) {}
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                hint: const Text(''),
                value: faultTypeValue,
                dropdownColor: Colors.blueGrey[50],
                itemHeight: null,
                menuMaxHeight: 292,
                borderRadius: BorderRadius.circular(10),
                alignment: AlignmentDirectional.center,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    faultTypeValue = newValue!;
                    idSpareValue =
                    spareTypeID[spareCodeName.indexOf(faultTypeValue) -1 ];
                    selectedDropDown.add(idSpareValue);
                  });
                },
                items: spareCodeName.isEmpty && spareCodeName == [""]
                    ? [
                  DropdownMenuItem<String>(
                    value: null,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 180,
                      child: const Center(
                          child: CircularProgressIndicator()),
                    ),
                  ),
                ]
                    : spareCodeName
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 180,
                      child: Center(child: Text(value)),
                    ),
                  );
                }).toList(),
              ),
              const Text(':نوع كود القطعه  ')
            ],
          ),
          const SizedBox(
            width: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                hint: const Text(''),
                value: repairInValue,
                dropdownColor: Colors.blueGrey[50],
                itemHeight: null,
                menuMaxHeight: 292,
                borderRadius: BorderRadius.circular(10),
                alignment: AlignmentDirectional.center,
                icon: const Icon(Icons.arrow_drop_down_sharp),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                onChanged: (String? newValue) {
                  setState(() {
                    repairInValue = newValue!;
                    idRepairValue = repairInID[repairIn.indexOf(repairInValue) - 1];
                    selectedDropDown.add(idRepairValue);
                  });
                },
                items: repairIn.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 180,
                      child: Center(child: Text(value)),
                    ),
                  );
                }).toList(),
              ),
              const Text(':Repair In  ')
            ],
          ),
          const SizedBox(
            height: 9.0,
          ),
          Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Checkbox(
              value: widget.isChecked,
              onChanged: (value) {
                if (kDebugMode) {
                  print(selectedDropDown);
                }

                if(idRepairValue != -1 && idSpareValue != -1 ) {
                  widget.onChecked(selectedDropDown);
                }
                else {
                  Fluttertoast.showToast(
                      msg: "Please select Values",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            const Text(":اختيار  ")
          ]))
        ],
      ),
    );
  }
}
