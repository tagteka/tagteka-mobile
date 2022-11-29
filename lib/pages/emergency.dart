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

import '../widget/NavBar.dart';

class Emergency extends StatefulWidget {
  static const String id = 'Home';

  const Emergency({Key? key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency>
    with SingleTickerProviderStateMixin {
  static const Color color4 = Color.fromARGB(255, 255, 255, 255);
  static const Color color3 = Color.fromARGB(156, 128, 221, 245);
  static const Color color2 = Color.fromARGB(183, 0, 138, 230);
  static const Color color = Color.fromARGB(211, 15, 113, 241);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 62),
            Text(
              'EMERGENCY',
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
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        ListView(
          children: [
            // Text(),
            // Text(),
            // Text(),
            // Text(),
          ],
        ),
      ],
    );
  }
}
