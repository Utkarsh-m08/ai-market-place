import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drone_market/screens/cart.dart';
import 'package:drone_market/screens/homePage/navBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:drone_market/properties/prop.dart';
import 'package:drone_market/screens/auth/login.dart';
import 'package:drone_market/screens/auth/logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class homePage extends StatefulWidget {
  homePage({
    super.key,
  });

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Map<String, dynamic>? catalogdata;
  List<Map<String, dynamic>> filtereddata = [];
  List<Map<String, dynamic>> searchedddata = [];
  TextEditingController editingController = TextEditingController();
  String filter = "All";
  final List<String> categories = [
    "All",
    "Electronics",
    "Clothing",
    "Accessories"
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      searchedddata = filtereddata;
      searchedddata = filtereddata
          .where((item) =>
              item["productName"].toLowerCase().contains(query.toLowerCase()) ||
              item["productBrand"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _loadData() async {
    searchedddata = [];
    filtereddata = [];
    final String response = await rootBundle.loadString('assets/data.json');
    catalogdata = await json.decode(response);
    for (var i = 0; i < catalogdata!.keys.length; i++) {
      if (filter != "All") {
        if (catalogdata![(i + 1).toString()]["Category"] == filter) {
          filtereddata.add(catalogdata![(i + 1).toString()]);
        }
      } else if (filter == "All") {
        filtereddata.add(catalogdata![(i + 1).toString()]);
      }
    }
    setState(() {
      searchedddata = filtereddata;
    });
  }

  //866.3 - height
//411.4 - width

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => userCart()));
              },
              icon: Icon(Icons.shopping_cart_outlined))
        ],
        title: Text(
          "Marketplace",
          style: GoogleFonts.sourceCodePro(
            color: rangText,
          ),
        ),
        backgroundColor: rangBackground,
      ),
      backgroundColor: rangBackground,
      body: catalogdata == null
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: const Color.fromARGB(255, 199, 110, 215),
                size: 80,
              ),
            )
          : Column(
              children: [
                SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: (screenWidth * 0.01215) / 2,
                                right: (screenWidth * 0.01215) / 2),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  filter = categories[index];
                                  _loadData();
                                });
                              },
                              child: Text(
                                categories[index],
                                style: TextStyle(
                                  color: rangText,
                                ),
                              ),
                            ),
                          );
                        })),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    style: GoogleFonts.sourceCodePro(
                      color: rangText,
                    ),
                    controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search",
                        fillColor: rangText,
                        focusColor: rangText,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: searchedddata.length,
                      itemBuilder: (BuildContext context, int index) {
                        return productDescription(
                            productdata: searchedddata[index]);
                      }),
                ),
              ],
            ),
    );
  }
}

class productDescription extends StatelessWidget {
  const productDescription({
    super.key,
    required this.productdata,
  });

  final Map<String, dynamic>? productdata;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    var user = FirebaseAuth.instance.currentUser;
    var db = FirebaseFirestore.instance;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: rangBackground),
        height: 400,
        width: screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: screenheight * 0.17315,
                    width: double.infinity,
                    child: Image.network(
                      productdata!["Product Image"],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.01154,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    productdata!["productBrand"] +
                        " " +
                        productdata!["productName"],
                    style: GoogleFonts.sourceCodePro(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.01154,
                ),
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: rangRedAccent),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(productdata!["Category"],
                              style: GoogleFonts.sourceCodePro(
                                  color: rangText, fontSize: 14)),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: rangRedAccent),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(productdata!["productBrand"],
                              style: GoogleFonts.sourceCodePro(
                                  color: rangText, fontSize: 14)),
                        )),
                  ],
                ),
                SizedBox(
                  height: screenheight * 0.01154,
                ),
                SingleChildScrollView(
                  child: Text(productdata!["Product Description"],
                      style: GoogleFonts.sourceCodePro(
                        color: rangText,
                        fontSize: 14,
                      )),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("₹${productdata!["Price (INR)"]}",
                          style: GoogleFonts.sourceCodePro(
                              color: rangText,
                              fontWeight: FontWeight.w800,
                              fontSize: 25)),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await db
                                .collection("users")
                                .doc(user!.uid.toString())
                                .collection("cart")
                                .add(productdata!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Item Added to Cart!'),
                                duration: Duration(milliseconds: 700)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.add,
                                color: rangRedAccent,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await db
                                .collection("users")
                                .doc(user!.uid.toString())
                                .collection("cart")
                                .add(productdata!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Item Added to Cart!'),
                                duration: Duration(milliseconds: 700)));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => userCart()));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.shopping_cart_checkout,
                                  color: rangRedAccent,
                                ),
                              )),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//https://images.unsplash.com/photo-1615789591457-74a63395c990?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9tZXN0aWMlMjBjYXR8ZW58MHx8MHx8fDA%3D
