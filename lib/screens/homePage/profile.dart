import 'package:drone_market/properties/prop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class profile extends StatefulWidget {
  const profile({super.key});
  // signout

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    // signout
    void signUserOut() async {
      FirebaseAuth.instance.signOut();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => infoPage(),
      //   ),
      // );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: rangBackground,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: screenheight * 0.02,
              // left: screenWidth * 0.02,
              // right: screenWidth * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: screenWidth * 0.4,
                  width: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    color: rangText,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Container(
                    height: screenWidth * 0.5,
                    width: screenWidth * 0.5,
                    decoration: BoxDecoration(
                      color: rangBackground,
                      // borderRadius: BorderRadius.all(
                      //   Radius.circular(30),
                      // ),
                    ),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                user.email!,
                                style: GoogleFonts.sourceCodePro(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.07,
                                  color: rangText,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mobile:",
                                style: GoogleFonts.sourceCodePro(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                  color: rangText,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Email: " + user.email!,
                                style: GoogleFonts.sourceCodePro(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                  color: rangText,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Address: ",
                                style: GoogleFonts.sourceCodePro(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                  color: rangText,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //     left: screenWidth * 0.03,
          //     right: screenWidth * 0.03,
          //     bottom: screenheight * 0.03,
          //   ),
          //   child: ElevatedButton.icon(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.edit,
          //       color: rangBackground,
          //     ),
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: rangText,
          //       foregroundColor: rangText,
          //       // shape: RoundedRectangleBorder(
          //       //   borderRadius: BorderRadius.circular(20),
          //       // ),
          //       elevation: 5,
          //     ),
          //     label: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text(
          //         "  edit account details",
          //         style:  GoogleFonts.sourceCodePro(
          //           // fontWeight: FontWeight.bold,
          //           fontSize: screenWidth * 0.05,
          //           color: rangBackground,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(
              top: screenheight * 0.08,
              bottom: screenheight * 0.02,
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
            ),
            child: Container(
              height: screenheight * 0.01,
              width: screenWidth * 0.4,
              color: rangText,
            ),
          ),
          Container(
            height: screenheight * 0.1,
            width: screenWidth * 0.5,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.history,
                  color: rangText,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rangBackground,
                  foregroundColor: rangBackground,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  elevation: 0,
                ),
                onPressed: () {
                  // signUserOut();
                },
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Orders",
                    style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.05,
                      color: rangText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 3,
              width: screenWidth * 0.4,
              color: rangText,
            ),
          ),
          Container(
            height: screenheight * 0.1,
            width: screenWidth * 0.5,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: rangText,
                  size: screenWidth * 0.08,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rangBackground,
                  foregroundColor: rangRedAccent,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  elevation: 0,
                ),
                onPressed: () {
                  // signUserOut();
                },
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Cart",
                    style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.05,
                      color: rangText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 3,
              width: screenWidth * 0.4,
              color: rangText,
            ),
          ),
          Container(
            height: screenheight * 0.1,
            width: screenWidth * 0.5,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.translate_outlined,
                  color: rangText,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rangBackground,
                  foregroundColor: rangRedAccent,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  elevation: 0,
                ),
                onPressed: () {
                  // signUserOut();
                },
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   language",
                    style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.05,
                      color: rangText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 3,
              width: screenWidth * 0.4,
              color: rangText,
            ),
          ),
          Container(
            height: screenheight * 0.1,
            width: screenWidth * 0.5,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.login_outlined,
                  color: rangText,
                  size: 40,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: rangBackground,
                  foregroundColor: rangRedAccent,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  elevation: 0,
                ),
                onPressed: () {
                  signUserOut();
                },
                label: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   Signout",
                    style: GoogleFonts.sourceCodePro(
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth * 0.05,
                      color: rangText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 3,
              width: screenWidth * 0.4,
              color: rangText,
            ),
          ),
        ],
      ),
    );
  }
}
