/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:productivo/pages/login.dart';
import '../components/styles.dart';
import '../widget/elevated_button.dart';

class Welcome extends StatefulWidget {
  static const String id = 'welcome';

  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text("Tagteka",
                //     style: TextStyle(
                //       fontSize: 32,
                //       color: Colors.black,
                //       fontFamily: "medium",
                //     )),
                Image(
                    image: NetworkImage(
                        'https://tagteka-assets.s3.us-east-2.amazonaws.com/TAGTEKA_Logo_V1.png')),
                SizedBox(height: 30),
                Text("Building Data Solutions",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Text('Login'))
              // Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [Colors.lightBlue.shade200, Colors.blue.shade800],
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //     ),
              //   ),
              //   width: double.infinity,
              //   child: MyElevatedButton(
              //     child: const Text("Login",
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontFamily: "medium",
              //         )),
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => const Login()));
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
