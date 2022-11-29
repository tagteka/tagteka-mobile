import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivo/widget/NavBar.dart';
import 'package:productivo/pages/asset_lookup_2.dart';

class AssetLookup extends StatefulWidget {
  static const String id = 'Asset';

  const AssetLookup({Key? key}) : super(key: key);

  @override
  _AssetLookup createState() => _AssetLookup();
}

class _AssetLookup extends State<AssetLookup>
    with SingleTickerProviderStateMixin {
  static const Color color4 = Color.fromARGB(255, 255, 255, 255);
  static const Color color3 = Color.fromARGB(156, 128, 221, 245);
  static const Color color2 = Color.fromARGB(183, 0, 138, 230);
  static const Color color = Color.fromARGB(211, 15, 113, 241);
  static const Color backgroundColor = Color.fromARGB(255, 243, 243, 243);

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: (20)),
                // decoration: BoxDecoration(border: Border.all()),
                height: 80,
                child: TextButton(
                  style: ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(color: Colors.transparent, width: 0),
                    ),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/Plumbing.jpg'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssetLookup2(s: 'Plumbing')),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: (20)),
                // decoration: BoxDecoration(border: Border.all()),
                height: 80,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/HVAC.jpg'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssetLookup2(s: 'HVAC')),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: (20)),
                // decoration: BoxDecoration(border: Border.all()),
                height: 80,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/Fire.jpg'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssetLookup2(s: 'Fire')),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: (20)),
                // decoration: BoxDecoration(border: Border.all()),
                height: 80,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/Electrical.jpg'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssetLookup2(s: 'Electrical')),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: (20)),
                // decoration: BoxDecoration(border: Border.all()),
                height: 80,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/Common.jpg'),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssetLookup2(s: 'Common')),
                    );
                  },
                ),
              ),
              // IconButton(
              //   hoverColor: Colors.transparent,
              //   iconSize: 200,
              //   icon: Image.asset('assets/images/Plumbing.jpg', height: 300),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => AssetLookup2(s: 'Plumbing')),
              //     );
              //   },
              // ),
              // IconButton(
              //   hoverColor: Colors.transparent,
              //   iconSize: 300,
              //   icon: Image.asset('assets/images/Fire.jpg', height: 200),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => AssetLookup2(s: 'Fire')),
              //     );
              //   },
              // ),
              // IconButton(
              //   hoverColor: Colors.transparent,
              //   iconSize: 300,
              //   icon: Image.asset('assets/images/Electrical.jpg', height: 200),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => AssetLookup2(s: 'Electrical')),
              //     );
              //   },
              // ),
              // IconButton(
              //   icon: Image.asset('assets/images/HVAC.jpg', height: 200),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => AssetLookup2(s: 'HVAC')),
              //     );
              //   },
              // ),
              // IconButton(
              //   icon: Image.asset('assets/images/Common.jpg', height: 200),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => AssetLookup2(s: 'Common')),
              //     );
              //   },
              // )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
