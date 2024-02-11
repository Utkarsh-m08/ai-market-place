import 'package:drone_market/properties/prop.dart';
import 'package:drone_market/screens/auth/login.dart';
import 'package:drone_market/screens/homePage/homePage.dart';
import 'package:drone_market/screens/homePage/navBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class signupPage extends StatefulWidget {
  const signupPage({super.key});

  @override
  State<signupPage> createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {
  // text controllers
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login func

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    // register
    void signup() async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => homePage(),
            ),
          );
        }
      }
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: rangBackground,
      body: Center(
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: screenheight * 0.6,
            width: screenWidth * 0.9,
            color: rangBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign-up here!",
                  style: GoogleFonts.sourceCodePro(
                    fontSize: screenWidth * 0.09,
                    fontWeight: FontWeight.bold,
                    color: rangText,
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     width: 4,
                    //     color: rangText,
                    //   ),
                    // ),
                    fillColor: rangBackground,
                    focusColor: rangBackground,
                    labelText: "Email",
                    // helperText: '',
                    filled: true,
                  ),
                  style: GoogleFonts.sourceCodePro(
                    // fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                    color: rangText,
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     width: 0,
                    //     color: rangText,
                    //   ),
                    // ),
                    fillColor: rangBackground,
                    focusColor: rangBackground,
                    labelText: "Password",
                    // helperText: '',
                    filled: true,
                  ),
                  style: GoogleFonts.sourceCodePro(
                    // fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.05,
                    color: rangText,
                  ),
                ),
                Container(
                  // height: screenheight * 0.065,
                  width: screenWidth * 0.4,
                  decoration: BoxDecoration(
                    color: rangRedAccent,
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      signup();
                    },
                    child: Text(
                      "Sign-up",
                      style: GoogleFonts.sourceCodePro(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.07,
                        color: rangText,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Account?",
                      style: GoogleFonts.sourceCodePro(
                        // fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                        color: rangText,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => loginPage(),
                          ),
                        );
                      },
                      child: Text(
                        "login",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.06,
                          color: rangText,
                        ),
                      ),
                    ),
                    Text(
                      "Here",
                      style: GoogleFonts.montserrat(
                        // fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                        color: rangText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
