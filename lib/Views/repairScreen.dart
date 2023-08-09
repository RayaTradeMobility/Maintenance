import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/getRecommendationRepairModel.dart';
import '../Constants/Constants.dart';

class RepairScreen extends StatefulWidget {
  final String workOrderId, siteRequestId;

  const RepairScreen({
    Key? key,
    required this.workOrderId,
    required this.siteRequestId,
  }) : super(key: key);

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  Icon customIcon = const Icon(Icons.search);
  List<Spares> sparesList = [];
  bool _isLoading = false;
  TextEditingController searchController = TextEditingController();
  List<TextEditingController> controllers = [];
  List <Spares> filteredItemList = [];

  API api = API();

  @override
  void initState() {
    super.initState();
    fetchRepairCases();
  }


  void filterCrop(value) {
    setState(() {
      filteredItemList = sparesList
          .where((e) =>
          e.spareCode!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchRepairCases() async {
    RecommendationModel fetchedRecommendation =
        await api.fetchRepairCases(widget.workOrderId, widget.siteRequestId);
    setState(() {
      sparesList = fetchedRecommendation.spares!;
       _isLoading = true;

    });
  }

  List<String> selectedSpareCodes = [];

  void toggleSpareCode(String spareCode) {
    setState(() {
      if (selectedSpareCodes.contains(spareCode)) {
        selectedSpareCodes.remove(spareCode);
      } else {
        selectedSpareCodes.add(spareCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 1),
      appBar: AppBar(
        backgroundColor: MyColorsSample.primary.withOpacity(0.8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        title: const Text("التصليح"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
                prefixIcon:Icon(Icons.search),
                hintText: "Search for repair code",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.blue)
                )
            ),
            onChanged: (value){
              filterCrop(value);

            },
          ),

          Expanded(
            child: _isLoading==false? const Center(child:CircularProgressIndicator()):searchController.text.isEmpty?ListView.builder(
              itemCount: sparesList.length,
              itemBuilder: (BuildContext context, int index) {
                controllers.add(TextEditingController());

                final Spares spares = sparesList[index];

                return CustomCard(
                  model: spares.model!,
                  offering: spares.offering!,
                  spareCode: spares.spareCode!,
                  spareDescription: spares.spareDescription!,
                  ccTReference: spares.ccTReference!,
                  cost: spares.cost!,
                  finalPrice: spares.finalPrice!,
                  campaignFinalPrice: spares.campaignFinalPrice!,
                  serviceCode: spares.serviceCode!,
                  serviceLevel: spares.serviceLevel!,
                  repairModule: spares.repairModule!,
                  isChecked: selectedSpareCodes.contains(spares.spareCode),
                  onChecked: () => toggleSpareCode(spares.spareCode!),
                );
              },
            ): searchController.text.isNotEmpty && filteredItemList.isEmpty
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search_off,
                        size: 80,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          'No results found,\nPlease try different keyword',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : filteredItemList.isNotEmpty
                ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: filteredItemList.length,
              itemBuilder: (BuildContext context, int index) {
                controllers.add(TextEditingController());

                return CustomCard(
                  model: filteredItemList[index].model!,
                  offering: filteredItemList[index].offering!,
                  spareCode: filteredItemList[index].spareCode!,
                  spareDescription: filteredItemList[index].spareDescription!,
                  ccTReference: filteredItemList[index].ccTReference!,
                  cost: filteredItemList[index].cost!,
                  finalPrice: filteredItemList[index].finalPrice!,
                  campaignFinalPrice: filteredItemList[index].campaignFinalPrice!,
                  serviceCode: filteredItemList[index].serviceCode!,
                  serviceLevel: filteredItemList[index].serviceLevel!,
                  repairModule: filteredItemList[index].repairModule!,
                  isChecked: selectedSpareCodes.contains(filteredItemList[index].spareCode),
                  onChecked: () => toggleSpareCode(filteredItemList[index].spareCode!),
                );
              },
            )
                : const Center(
              child: CircularProgressIndicator(), // Show CircularProgressIndicator if no data is available yet
            ),
          ),
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
              if (kDebugMode) {
                print(selectedSpareCodes);
              }
            },
            child: const Text("طلب"),
          )
        ],
      ),
    );
  }
}

class CustomCard extends StatefulWidget {
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

  const CustomCard({
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
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
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
                '${widget.offering} :العرض ',
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
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w500),
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
                '${widget.ccTReference} :CC T Reference ',
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
                '${widget.cost} :التكلفة ',
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
                '${widget.finalPrice} :السعر النهائي ',
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
                '${widget.campaignFinalPrice} :سعر الحملة النهائي ',
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
                '${widget.serviceCode} :كود الخدمة ',
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
                '${widget.serviceLevel} :مستوى الخدمة ',
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
                '${widget.repairModule} :وحدة الإصلاح ',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                width: 5.0,
              ),
            ],
          ),
          Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
