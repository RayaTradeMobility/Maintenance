import 'package:collapsible/collapsible.dart';
import 'package:flutter/material.dart';

class InstallationScreen extends StatefulWidget {
  const InstallationScreen({Key? key}) : super(key: key);


  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen> with SingleTickerProviderStateMixin{
  Widget customSearchBar = const Text("التركيب");

  bool _collapse = false,
      collapse = false;
  TextEditingController commentController  = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.grey),
            child: const Text('طلب'),
          ),

        ],
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(59, 60, 54,20),
        title: customSearchBar,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body:SizedBox(
        width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,

    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(
    child: Column(
    children: [
    Card(
    elevation: 5.0,
    shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    children: [
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
    const Center(
      child: Text(
      'بيانات العميل ',
      style: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 21),
      ),
    ),
    IconButton(
    onPressed: () {
    setState(() {
    if (_collapse == true) {
    _collapse = false;
    } else {
    _collapse = true;
    }
    });
    },
    icon: const Icon(Icons.arrow_drop_down))
    ],
    ),
    const Divider(
    thickness: 0.8,
    color: Color(0xFF3f8dfd),
    ),
    Collapsible(
    collapsed: _collapse,
    axis: CollapsibleAxis.vertical,
    alignment: Alignment.bottomLeft,
    child: const Column(
    children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Text(
    ":الاسم الاول ",
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold),
    ),
      Icon(
        Icons.account_circle,
        color: Colors.grey,
      ),

    ],
    ),
      SizedBox(
        height: 5.0,
      ),
      Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Text(
    ':الاسم الاخير ',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold),
    ),
      Icon(
        Icons.account_box_rounded,
        color: Colors.grey,
      ),


    ],
    ),
      SizedBox(
        height: 5.0,
      ),
      Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Text(
    ':رقم الموبايل ',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold),
    ),
      Icon(
        Icons.phone_android,
        color: Colors.grey,
      ),


    ],
    ),
      SizedBox(
        height: 5.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            ':المدينه ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.mobile_friendly,
            color: Colors.grey,
          ),


        ],
      ),
      SizedBox(
        height: 5.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Text(
    ':المنطقه ',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold),
    ),
      Icon(
        Icons.location_city,
        color: Colors.grey,
      ),
    ],
    ),
      SizedBox(
        height: 5.0,
      ),
      Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    Text(
    ':العنوان',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold),
    ),
      Icon(
        Icons.location_on,
        color: Colors.grey,
      ),

    ],
    ),
      SizedBox(
        height: 5.0,
      ),

    ],
    ),
    ),
    ],
    ),
    ),
    ),
    Card(
    elevation: 5.0,
    shape: BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
    children: [
    Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
    const Text(
    'البيانات',
    style: TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 21),
    ),
    IconButton(
    onPressed: () {
    setState(() {
    if (collapse == true) {
    collapse = false;
    } else {
    collapse = true;
    }
    });
    },
    icon: const Icon(Icons.arrow_drop_down))
    ],
    ),
    const Divider(
    thickness: 0.8,
    color: Color(0xFF3f8dfd),
    ),
    Collapsible(
    collapsed: collapse,
    axis: CollapsibleAxis.vertical,
    alignment: Alignment.bottomLeft,
    child:  const Column(
    children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
    children: [
    SizedBox(
    width: 5.0,
    ),
    Text(
    ':السريال ',
    style: TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold),
    ),
    ],
    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Text(
            ':القسم ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Text(
            ':المركه ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Text(
            ':المنتج ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Text(
            ':السريال الداخلي ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Text(
            ':السريال الخارجي ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Text(
            ':المشكله ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 5.0,
          ),
          Text(
            ':نوع المشكله ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),

       // Row(
       //   children: [
       //     const SizedBox(
       //       width: 5.0,
       //     ),
       //     const Text(
       //       ':ملاحظه ',
       //       style: TextStyle(
       //           color: Colors.black,
       //           fontWeight: FontWeight.bold),
       //     ),
       //     TextFormField(
       //       controller: commentController,
       //       decoration: const InputDecoration(
       //         labelText: ' Comment',
       //       ),
       //       onChanged: (value) {},
       //     ),
       //   ],
       // ),

    ],
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    )),
    ),
    ),
    );
  }
}
