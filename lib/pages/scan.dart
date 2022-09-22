import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivo/widget/NavBar.dart';
import '../components/styles.dart';
import 'package:flutter/material.dart';
import 'package:productivo/networking/requests.dart';

class Scan extends StatefulWidget {
  static const String id = 'Scan';

  const Scan({Key? key}) : super(key: key);

  @override
  _Scan createState() => _Scan();
}

class _Scan extends State<Scan> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: appColor,
        toolbarHeight: 70,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text(
          "Scans",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: _connectSled,
                icon: Icon(
                  Icons.check_box,
                  color: appColor,
                  size: 20,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: _scan,
                icon: Icon(
                  Icons.cast_connected,
                  color: appColor,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            unselectedLabelColor: Colors.black45,
            labelColor: appColor,
            controller: _tabController,
            indicatorColor: appColor,
            labelStyle: TextStyle(fontFamily: 'medium', fontSize: 14),
            unselectedLabelStyle: TextStyle(fontFamily: 'medium', fontSize: 14),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text('Scans'.toUpperCase(),
                    style: TextStyle(fontFamily: 'medium')),
              ),
              Tab(
                child: Text('Locate Tag by #'.toUpperCase(),
                    style: TextStyle(fontFamily: 'medium')),
              ),
              // Tab(
              //   child: Text('Tags'.toUpperCase(),
              //       style: TextStyle(fontFamily: 'medium')),
              // ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotes(),
                // _buildFolder(),
                // _buildNotesdtl(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotes() {
    return SingleChildScrollView(
      child: Column(
        children: _scans.map((e) => _buildNotesdtl(e)).toList(),
      ),
    );
  }

  Widget _buildNotesdtl(str) {
    return FutureBuilder(
        future: Requests().getAsset(str),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$str",
                        style: TextStyle(fontFamily: 'semibold', fontSize: 18),
                      ),
                      Text(
                        "Today, 16.00",
                        style: TextStyle(color: Colors.black38, fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      chips(str),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Lorem ipsum dollor sit amet, adi plass cing elit. In libero nulla, msalaskued ameta, consedena",
                    style: TextStyle(color: Colors.black38, fontSize: 14),
                  ),
                ],
              ),
            );
          }
        });
  }

  chips(type) {
    Color c;
    switch (type) {
      case 'fire':
        c = Color.fromARGB(255, 240, 65, 65);
        break;
      default:
        c = Colors.white;
    }
    return Container(
      padding: EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          'Lorem'.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        backgroundColor: c,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Colors.white,
  //       drawer: NavBar(),
  //       appBar: AppBar(
  //         backgroundColor: appColor,
  //         iconTheme: const IconThemeData(color: Colors.white),
  //         elevation: 0,
  //         toolbarHeight: 60,
  //         title: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Scan for Nearby Tags",
  //               style: TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       body: Container(
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     OutlinedButton(
  //                       style: ButtonStyle(
  //                           fixedSize: MaterialStateProperty.all(
  //                               Size.fromWidth(150.0)),
  //                           shape: MaterialStateProperty.all(
  //                               RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(7.0),
  //                           ))),
  //                       onPressed: () => {_connectSled()},
  //                       child: const Text('Connect'),
  //                     ),
  //                     OutlinedButton(
  //                       style: ButtonStyle(
  //                           fixedSize: MaterialStateProperty.all(
  //                               Size.fromWidth(150.0)),
  //                           shape: MaterialStateProperty.all(
  //                               RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(7.0),
  //                           ))),
  //                       onPressed: () => {_disconnectSled()},
  //                       child: const Text('Disconnect'),
  //                     ),
  //                   ]),
  //               Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     OutlinedButton(
  //                       style: ButtonStyle(
  //                           fixedSize: MaterialStateProperty.all(
  //                               Size.fromWidth(150.0)),
  //                           shape: MaterialStateProperty.all(
  //                               RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(7.0)))),
  //                       onPressed: () => {_scan()},
  //                       child: const Text('Start Scan'),
  //                     ),
  //                     OutlinedButton(
  //                       style: ButtonStyle(
  //                           fixedSize: MaterialStateProperty.all(
  //                               Size.fromWidth(150.0)),
  //                           shape: MaterialStateProperty.all(
  //                               RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(7.0)))),
  //                       onPressed: () => {_stopScan()},
  //                       child: const Text('Stop Scan'),
  //                     ),
  //                   ]),
  //               TabBar(
  //                 tabs: [
  //                   Tab(
  //                     child: Text('Scanned Items'.toUpperCase(),
  //                         style: TextStyle(fontFamily: 'medium')),
  //                   ),
  //                   Expanded(
  //                       child: TabBarView(
  //                     controller: _tabController,
  //                     children: [
  //                       _buildScans(),
  //                       _buildNotesdtl(),
  //                     ],
  //                   ))
  //                 ],
  //               )
  //             ],
  //           )));
  // }

  static const platform =
      const MethodChannel('com.tagteka.Prodctivo/bluebirdSled');

  // Connection status
  String _connected = 'Sled connection status unknown.';
  List<String> _scans = [];

  Future _connectSled() async {
    String connected;
    try {
      final String msg = await platform.invokeMethod('connectSled');
      connected = msg;
      final ret = await platform.invokeMethod('scanTags');
    } on PlatformException catch (e) {
      connected = e.toString();
      print(e);
    }
    setState(() {
      _connected = connected;
    });
  }

  Future _disconnectSled() async {
    String connected;
    try {
      final String msg = await platform.invokeMethod('disconnectSled');
      connected = msg;
    } on PlatformException catch (e) {
      connected = e.toString();
      print(e);
    }
    setState(() => _connected = connected);
  }

  Future _scan() async {
    List<String> scans = [];
    try {
      final temp = await platform.invokeMethod('scanTags');
      temp.forEach((element) => scans.add(element));
      _scans = scans;
    } on PlatformException catch (e) {
      scans[0] = e.message == null
          ? "Error; could not invoke scanTags"
          : e.message.toString();
    }
    setState(() => _scans = scans);
  }

  Future _fetch() async {
    List<String> inventory = [];
    try {
      final temp = await platform.invokeMethod('fetchList');
      temp.forEach((element) => inventory.add(element));
      _scans = inventory;
    } on PlatformException catch (e) {
      inventory[0] = e.message == null
          ? "Error; could not fetch scans."
          : e.message.toString();
    }
    setState(() => _scans = inventory);
  }

  Future _stopScan() async {
    List<String> scans = [];
    try {
      final temp = await platform.invokeMethod('stopScan');
    } on PlatformException catch (e) {
      scans[0] = e.message == null
          ? "Error; could not invoke stopScan"
          : e.message.toString();
    }
    setState(() => _scans = scans);
  }

  void _clearList() {
    List<String> scans = [];
    _scans.clear();
    setState() {
      scans = _scans;
    }
  }
}
