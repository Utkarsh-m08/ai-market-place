import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drone_market/properties/prop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class userCart extends StatefulWidget {
  userCart({super.key});

  @override
  State<userCart> createState() => _userCartState();
}

class _userCartState extends State<userCart> {
  late Map<String, Map<String, dynamic>> cart = {};
  final User? user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  int total = 0;
  String totalString = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    total = 0;
    cart = {};
    var user = FirebaseAuth.instance.currentUser;
    var db = FirebaseFirestore.instance;
    await db
        .collection("users")
        .doc(user!.uid.toString())
        .collection("cart")
        .get()
        .then((event) {
      for (var doc in event.docs) {
        cart[doc.id.toString()] = (doc.data());
        total += doc.data()["Price (INR)"] as int;
      }
    });
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    totalString = total.toString().replaceAllMapped(reg, mathFunc);
    setState(() {
      print(total);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: cart.isEmpty
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: const Color.fromARGB(255, 199, 110, 215),
                size: 80,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cart.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 14),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: rangBackground,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 150,
                                        width: 100,
                                        child: Image.network(
                                          cart.values.toList()[index]
                                              ["Product Image"],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            width: 210,
                                            child: Text(
                                              cart.values.toList()[index]
                                                      ["productBrand"] +
                                                  " " +
                                                  cart.values.toList()[index]
                                                      ["productName"],
                                              style: GoogleFonts.sourceCodePro(
                                                color: Colors.black,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w800,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          "₹${cart.values.toList()[index]["Price (INR)"]}",
                                          style: GoogleFonts.sourceCodePro(
                                              color: rangText,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 25),
                                          textAlign: TextAlign.left,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await db
                                                .collection("users")
                                                .doc(user!.uid.toString())
                                                .collection("cart")
                                                .doc(cart.keys.toList()[index])
                                                .delete();
                                            await _loadData();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Item Deleted from Cart!'),
                                              duration:
                                                  Duration(milliseconds: 700),
                                            ));
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Icon(
                                                  Icons.delete,
                                                  color: rangRedAccent,
                                                ),
                                              )),
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      }),
                ),
                // SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 14, bottom: 10),
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: rangBackground,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total: ",
                          style: GoogleFonts.sourceCodePro(
                              color: rangText,
                              fontWeight: FontWeight.w800,
                              fontSize: 25),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "₹$totalString",
                          style: GoogleFonts.sourceCodePro(
                              color: rangText,
                              fontWeight: FontWeight.w800,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
