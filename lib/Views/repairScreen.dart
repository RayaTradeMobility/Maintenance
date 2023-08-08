// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/getRecommendationRepair.dart';
import '../Constants/Constants.dart';

class RepairScreen extends StatefulWidget {
  final String workOrderId , siteRequestId;
  const RepairScreen({Key? key, required this.workOrderId, required this.siteRequestId,}) : super(key: key);

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}
class _RepairScreenState extends State<RepairScreen> {
  Icon customIcon = const Icon(Icons.search);
  List<Spares> SparesList = [];


  API api = API();

  @override
  void initState() {
    super.initState();
    api.fetchRepairCases(widget.workOrderId,widget.siteRequestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      appBar: AppBar(
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        title: const Text("التصليح"),
        centerTitle: true,
        automaticallyImplyLeading: true ,
      ),
      body: Column(
        children:[ListView.builder(
          itemCount: SparesList.length,
          itemBuilder: (BuildContext context, int index) {

              return CustomCard(
                model: SparesList[index].model!,
                offering:SparesList[index].offering!,
                spareCode: SparesList[index].spareCode!,
                spareDescription:SparesList[index].spareDescription!,
                ccTReference: SparesList[index].ccTReference!,
                cost: SparesList[index].cost!,
                finalPrice: SparesList[index].finalPrice!,
                campaignFinalPrice: SparesList[index].campaignFinalPrice!,
                serviceCode: SparesList[index].serviceCode!,
                serviceLevel: SparesList[index].serviceLevel!,
                repairModule: SparesList[index].repairModule!,

              );

            // return Container(
            //     width:40, height: 50,
            //     color: Colors.black, child: const Text("No Data To Show"));
          },
        ),
      ]
      )
    );
  }
}

class CustomCard extends StatelessWidget {
  final String model, offering, spareCode, spareDescription, ccTReference, cost, finalPrice,
      campaignFinalPrice, serviceCode, serviceLevel, repairModule;

  const CustomCard(
      {Key? key, required this.model, required this.offering,
        required this.spareCode, required this.spareDescription,
        required this.ccTReference, required this.cost, required this.finalPrice,
        required this.campaignFinalPrice, required this.serviceCode,
        required this.serviceLevel, required this.repairModule,
       }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Scaffold()
        )
        );},
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
                      '$model :الموديل  ',
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
                      '$offering :offering',
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
                      '$spareCode :spareCode',
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
                      spareDescription,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Text(
                      ' :spareDescription',
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
                      '$ccTReference :ccTReference',
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
                      finalPrice,
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(" :finalPrice"),
                    const Icon(
                      Icons.tire_repair,
                      color: Colors.grey,
                    ),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$campaignFinalPrice :campaignFinalPrice',
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$serviceCode :serviceCode',
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$cost :cost',
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$serviceLevel :serviceLevel',
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$repairModule :repairModule',
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
            ],
          )),
    );
  }
}

