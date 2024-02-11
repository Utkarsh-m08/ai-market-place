import 'package:drone_market/properties/prop.dart';
import 'package:drone_market/screens/auth/login.dart';
import 'package:drone_market/screens/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act/slide_to_act.dart';

class landing extends StatefulWidget {
  const landing({super.key});

  @override
  State<landing> createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: rangBackground,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  width: screenWidth * 0.02,
                  color: rangText,
                )),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Container(
                        height: screenheight * 0.1,
                      ),
                      Row(
                        children: [
                          Text(
                            "B.I.Y.\nMarketplace",
                            style: GoogleFonts.sourceCodePro(
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.13,
                              color: rangText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: screenheight * 0.04,
                      ),
                      Container(
                        color: rangText,
                        height: screenheight * 0.01,
                      ),
                      Container(
                          // height: screenheight * 0.06,
                          ),
                      Container(
                        height: screenheight * 0.3,
                        // width: screenWidth * 0.8,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: screenWidth * 0.2,
                              // color: rangAccent,
                              child: Text(
                                "\nSomething 1",
                                style: GoogleFonts.sourceCodePro(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.08,
                                  color: rangText,
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.6,
                              color: rangBackground,
                              child: Text(
                                "\n\nSomething 2",
                                style: GoogleFonts.sourceCodePro(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.08,
                                  color: rangRedAccent,
                                ),
                              ),
                            ),
                            Container(
                              color: rangBackground,
                              child: Text(
                                "\nSomething 3",
                                style: GoogleFonts.sourceCodePro(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.08,
                                  color: rangBlueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         Text(
                      //           "something something",
                      //           style: GoogleFonts.sourceCodePro(
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: screenWidth * 0.05,
                      //             color: rangText,
                      //           ),
                      //         ),
                      //         Text(
                      //           "something something",
                      //           style: GoogleFonts.sourceCodePro(
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: screenWidth * 0.05,
                      //             color: rangText,
                      //           ),
                      //         ),
                      //         Text(
                      //           "something something",
                      //           style: GoogleFonts.sourceCodePro(
                      //             fontWeight: FontWeight.w500,
                      //             fontSize: screenWidth * 0.05,
                      //             color: rangText,
                      //           ),
                      //         ),
                      //       ],
                      //     )
                      //   ],
                      // ),
                      Container(
                          // height: screenheight * 0.1,
                          ),
                    ],
                  ),
                ),
              ),
              Container(
                height: screenheight * 0.1,
              ),
              // getting started starts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // login
                  Container(
                    height: screenheight * 0.08,
                    width: screenWidth * 0.4,
                    child: ElevatedButton(
                      child: Text(
                        "Login",
                        style: GoogleFonts.sourceCodePro(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                          color: rangBackground,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenheight * 0.4),
                        ),
                        elevation: 50,
                        backgroundColor: rangRedAccent,
                        foregroundColor: rangText,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: rangBackground,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          elevation: 50,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: screenheight * 0.7,
                              child: loginPage(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // signup
                  Container(
                    height: screenheight * 0.08,
                    width: screenWidth * 0.4,
                    child: ElevatedButton(
                      child: Text(
                        "sign-up",
                        style: GoogleFonts.sourceCodePro(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                          color: rangBackground,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenheight * 0.5),
                        ),
                        // elevation: 5,
                        backgroundColor: rangRedAccent,
                        foregroundColor: rangBackground,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          backgroundColor: rangBackground,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          elevation: 10,
                          context: context,
                          builder: (BuildContext context) {
                            return signupPage();
                          },
                        );
                      },
                    ),
                  ),
                  // or getting started
                  // SlideAction(
                  //   onSubmit: () {
                  //     // showModalBottomSheet(
                  //     //   backgroundColor: rangBackground,
                  //     //   shape: const RoundedRectangleBorder(
                  //     //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     //   ),
                  //     //   elevation: 50,
                  //     //   context: context,
                  //     //   builder: (BuildContext context) {
                  //     //     return Container(
                  //     //       height: screenheight * 0.7,
                  //     //       child: loginPage(),
                  //     //     );
                  //     //   },
                  //     // );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
