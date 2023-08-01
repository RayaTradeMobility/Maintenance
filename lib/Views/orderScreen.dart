import 'package:flutter/material.dart';
import 'package:maintenance/Views/installationScreen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);


  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin{
  Widget customSearchBar = const Text("الطلبات");
  Icon customIcon = const Icon(Icons.search);
  TextEditingController searchController = TextEditingController();
   TabController? _tabController ;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }
  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(59, 60, 54,20),
        title: customSearchBar,
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              if (customIcon.icon == Icons.search) {
                setState(() {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    leading: IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return  const Scaffold();
                          }),
                        );
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    title: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'الطلبات',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }
                );
              }
              else {
                setState(() {
                  customIcon = const Icon(Icons.search);
                });
              }
            },
            icon: customIcon,
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: TabBar(

                  isScrollable: false,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ),
                    color: Colors.black,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'تركيب',
                    ),

                    Tab(
                      text: 'تصليح',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () async {
                        _refreshIndicatorKey.currentState?.show();
                        setState(() {});
                      },
                      child:  SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [ GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1 / 0.5,
                              crossAxisCount: 1,
                              children:
                              List.generate(8, (index) => const CustomCard()),
                            ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    RefreshIndicator(
                      key: _refreshIndicatorKey2,
                      onRefresh: () async {
                        _refreshIndicatorKey2.currentState?.show();
                        setState(() {
                        });
                      },

                      child:  const SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [ Text("Data")

                              ],
                            ),
                          )),
                    ),
                    // second tab bar view widget
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InstallationScreen()),
        );
      },
      child:  Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),

          clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
            Text(':الاسم الاول', style: TextStyle(color: Colors.black),),
                SizedBox(
                  width: 5.0,
                ),
            Icon(
              Icons.account_circle,
              color: Colors.grey,
            ),
              ]
          ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Text(':الاسم الاخير', style: TextStyle(color: Colors.black),),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.account_box_rounded,
                    color: Colors.grey,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Text(':رقم الموبايل', style: TextStyle(color: Colors.black),),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.mobile_friendly,
                    color: Colors.grey,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Text(':المدينه', style: TextStyle(color: Colors.black),),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.location_city,
                    color: Colors.grey,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Text(':المنطقه', style: TextStyle(color: Colors.black),),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.zoom_out,
                    color: Colors.grey,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Text(':العنوان', style: TextStyle(color: Colors.black),),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children:[
                  Text(': العطل', style: TextStyle(color: Colors.black),),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.tire_repair,
                    color: Colors.grey,
                  ),
                ]
            ),          ],
        )
      ),
    );
  }
}