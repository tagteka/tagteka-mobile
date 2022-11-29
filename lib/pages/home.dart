/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivo/pages/asset_lookup.dart';
import 'package:productivo/pages/create_new_event.dart';
import 'package:productivo/widget/NavBar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import '../components/styles.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:productivo/pages/scan.dart';
import 'package:productivo/pages/emergency.dart';

class Home extends StatefulWidget {
  static const String id = 'Home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  static const Color color4 = Color.fromARGB(255, 255, 255, 255);
  static const Color color3 = Color.fromARGB(156, 128, 221, 245);
  static const Color color2 = Color.fromARGB(183, 0, 138, 230);
  static const Color color = Color.fromARGB(211, 15, 113, 241);

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 62),
            Text(
              'TAGTEKA',
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[color, color2, color3, color4]),
          ),
        ),
      ),
      body: buildBody(),
    ));
  }

  Widget buildBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // DropShadow(
              Container(
                width: 150,
                height: 150,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(8)),
                //   border: Border(
                //     top: BorderSide(
                //         width: 2, color: Color.fromARGB(200, 0, 0, 0)),
                //     left: BorderSide(
                //         width: 2, color: Color.fromARGB(200, 0, 0, 0)),
                //     right: BorderSide(
                //         width: 2, color: Color.fromARGB(200, 0, 0, 0)),
                //     bottom: BorderSide(
                //         width: 2, color: Color.fromARGB(200, 0, 0, 0)),
                //   ),
                // ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(75, 100, 100, 100),
                      blurRadius: 15,
                      offset: const Offset(-3, 5),
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 100,
                      icon: Image.asset('assets/images/001scanner.png',
                          height: 75),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Scan()),
                        );
                      },
                    ),
                    Text(
                      'SCAN',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.ideographic,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 600),
                  )
                  .moveY(begin: 25, end: 0),
              //   blurRadius: 3,
              //   spread: 1,
              //   offset: const Offset(3, 3),
              // ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(75, 100, 100, 100),
                      blurRadius: 15,
                      offset: const Offset(-3, 5),
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 100,
                      icon: Image.asset('assets/images/001-fixed-asset.png',
                          height: 75),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssetLookup()),
                        );
                      },
                    ),
                    Text(
                      'ASSETS',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.ideographic,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 600),
                  )
                  .moveY(begin: 25, end: 0),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(75, 100, 100, 100),
                      blurRadius: 15,
                      offset: const Offset(-3, 5),
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 100,
                      icon: Image.asset('assets/images/003-dashboard.png',
                          height: 75),
                      onPressed: () {},
                    ),
                    Text(
                      'ANALYTICS',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.ideographic,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 600),
                  )
                  .moveY(begin: 25, end: 0),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(75, 100, 100, 100),
                      blurRadius: 15,
                      offset: const Offset(-3, 5),
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 100,
                      icon: Image.asset('assets/images/email.png', height: 75),
                      onPressed: () {},
                    ),
                    Text(
                      'EMAIL',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.ideographic,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 600),
                  )
                  .moveY(begin: 25, end: 0),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(75, 100, 100, 100),
                      blurRadius: 15,
                      offset: const Offset(-3, 5),
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 100,
                      icon: Image.asset('assets/images/009-calendar.png',
                          height: 60),
                      onPressed: () {},
                    ),
                    Text(
                      'CALENDAR',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.ideographic,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 600),
                  )
                  .moveY(begin: 25, end: 0),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(75, 100, 100, 100),
                      blurRadius: 15,
                      offset: const Offset(-3, 5),
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      iconSize: 100,
                      icon: Image.asset('assets/images/alert.png', height: 60),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Emergency()),
                        );
                      },
                    ),
                    Text(
                      'EMERGENCY',
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.ideographic,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(
                    delay: Duration(milliseconds: 100),
                    duration: Duration(milliseconds: 600),
                  )
                  .moveY(begin: 25, end: 0),
            ],
          )
        ],
      ),
    );
  }
}
