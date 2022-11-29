import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivo/widget/NavBar.dart';
import 'package:productivo/pages/asset_lookup_2.dart';

class AssetLookup2 extends StatefulWidget {
  static const String id = 'Asset2';
  String s = 'default';
  AssetLookup2({Key? key, required this.s}) : super(key: key);

  @override
  _AssetLookup2 createState() => _AssetLookup2(s);
}

class _AssetLookup2 extends State<AssetLookup2> {
  String s = 'reached2';
  @override
  void initState() {
    super.initState();
  }

  _AssetLookup2(s) {
    this.s = s;
  }
  static const Color color4 = Color.fromARGB(255, 255, 255, 255);
  static const Color color3 = Color.fromARGB(156, 128, 221, 245);
  static const Color color2 = Color.fromARGB(183, 0, 138, 230);
  static const Color color = Color.fromARGB(211, 15, 113, 241);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget buildBody() {
    return Container(
      child: Column(
        children: [
          IconButton(
            hoverColor: Colors.transparent,
            iconSize: 200,
            icon: Image.asset('assets/images/001scanner.png', height: 75),
            onPressed: () {
              print(this.s);
            },
          ),
          IconButton(
            icon: Image.asset('assets/images/001scanner.png', height: 75),
            onPressed: () {
              print(this.s);
            },
          ),
          IconButton(
            icon: Image.asset('assets/images/001scanner.png', height: 75),
            onPressed: () {
              print(this.s);
            },
          ),
          IconButton(
            icon: Image.asset('assets/images/001scanner.png', height: 75),
            onPressed: () {
              print(this.s);
            },
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
