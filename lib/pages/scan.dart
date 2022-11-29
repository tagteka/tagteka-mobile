import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productivo/pages/edit_asset.dart';
import 'package:productivo/widget/NavBar.dart';
import '../components/styles.dart';
import 'package:flutter/material.dart';
import '../models/asset_model.dart';
import 'package:productivo/networking/requests.dart';
import 'package:productivo/pages/edit_asset.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../pages/scan_detail.dart';

class Scan extends StatefulWidget {
  static const String id = 'Scan';

  const Scan({Key? key}) : super(key: key);

  @override
  _Scan createState() => _Scan();
}

class _Scan extends State<Scan> with SingleTickerProviderStateMixin {
  bool isConnected = false;
  String buttonText = "Connect";
  String connectionStatus = "Disconnected";
  TabController? _tabController;
  bool _isChecked = false;
  FToast fToast = FToast();

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    fToast.init(context);
    // _disconnectSled();
    super.initState();
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
        toolbarHeight: 60,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          Container(
            child: Text(
              connectionStatus,
              style:
                  TextStyle(backgroundColor: appColor, color: (Colors.white)),
            ),
            margin: EdgeInsets.only(top: (21.68), right: 10),
          ),
          TextButton(
            child: Text(buttonText),
            onPressed: _toggleConnection,
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: appColor),
                )),
                backgroundColor: MaterialStateProperty.all<Color>(appColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
          ),
        ],
        title: Text(
          "Scans",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildHeader() {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      color: appColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            // child: Theme(
            //   data: ThemeData(unselectedWidgetColor: Colors.white),
            child: CheckboxListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('Filter',
                  style: TextStyle(
                      fontSize: 16,
                      backgroundColor: (appColor),
                      color: (Colors.white))),
              subtitle: Text(
                'Only display registered items.',
                style: TextStyle(
                  fontSize: 10,
                  backgroundColor: appColor,
                  color: Colors.black38,
                ),
              ),
              checkColor: appColor,
              tileColor: Colors.white,
              selectedTileColor: Colors.white,
              activeColor: Colors.white,
              value: _isChecked,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() => _isChecked = value!);
              },
            ),
          ),
          // ),
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
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
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
              // Tab(
              //   child: Text('Locate Tag by #'.toUpperCase(),
              //       style: TextStyle(fontFamily: 'medium')),
              // ),
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
                _buildAssets(),
                // _buildFolder(),
                // _buildNotesdtl(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssets() {
    return SingleChildScrollView(
      child: Column(
        children: _scans.map((e) => _buildAssetdtl(e)).toList(),
      ),
    );
  }

  Widget _buildAssetdtl(str) {
    int rnh = DateTime.now().hour;
    int rnm = DateTime.now().minute;
    return FutureBuilder(
        future: Requests().getAsset(str),
        builder: (context, AsyncSnapshot<AssetModel?> snapshot) {
          if (snapshot.hasData) {
            String name = snapshot.data!.name;
            String tagID = snapshot.data!.id;
            // String lastService = snapshot.data!.lastService.toString();
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanDetail(am: snapshot.data),
                  ),
                );
              },
              child: Container(
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
                          "$tagID",
                          style:
                              TextStyle(fontFamily: 'semibold', fontSize: 18),
                        ),
                        Text(
                          "Today, $rnh:$rnm",
                          style: TextStyle(color: Colors.black38, fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        chips(snapshot.data!.category),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(height: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Item: ",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "$name",
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Last Service: ",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Sept 30, 2022",
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            if (!_isChecked) {
              print(str);
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAsset(str: str, newItem: true),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.black12),
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Not in database",
                              style: TextStyle(
                                  fontFamily: 'semibold', fontSize: 18),
                            ),
                            Text(
                              "Today, $rnh:$rnm",
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 10),
                            ),
                          ],
                        ),
                        Text(
                          "id: $str",
                        ),
                      ]),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          } else {
            return SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  chips(type) {
    Color c;
    switch (type) {
      case 'Fire':
        c = Color.fromARGB(255, 240, 65, 65);
        break;
      case 'Plumbing':
        c = Color.fromARGB(255, 10, 135, 205);
        break;
      case 'Electrical':
        c = Color.fromARGB(255, 245, 230, 20);
        break;
      default:
        c = Colors.white;
    }
    return Container(
      padding: EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          type == 'Fire' ? 'FIRE SAFETY' : type.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        backgroundColor: c,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
    );
  }

  static const platform =
      const MethodChannel('com.tagteka.Prodctivo/bluebirdSled');

  // Connection status
  String _connected = 'Sled connection status unknown.';
  List<String> _scans = [];

  Future _toggleConnection() async {
    String _buttonText = "";
    if (isConnected) {
      isConnected = false;
      _disconnectSled();
      _buttonText = "Connect";
    } else {
      isConnected = true;
      _connectSled();
      _buttonText = "Disconnect";
    }
    // _scan();
    setState(() {
      buttonText = _buttonText;
    });
  }

  Future _connectSled() async {
    String connected;
    FToast fToast = FToast();
    fToast.init(context);
    try {
      final String msg = await platform.invokeMethod('connectSled');
      connected = msg;
      // final ret = await platform.invokeMethod('scanTags');
      setState(() {
        connectionStatus = 'Connected';
        _connected = connected;
      });
    } on PlatformException catch (e) {
      connected = e.toString();
      print(e);
    }
    print(connected);
    fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: Colors.greenAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check),
              SizedBox(
                width: 6.0,
              ),
              Text("Scanner connected.",
                  style: TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
        ),
        positionedToastBuilder: (context, child) {
          return Positioned(child: child, bottom: 10, right: 10);
        },
        toastDuration: Duration(seconds: 1, microseconds: 500));
    setState(() {
      _scans.clear();
    });
  }

  Future _disconnectSled() async {
    FToast fToast = FToast();
    fToast.init(context);
    String connected;
    try {
      final String msg = await platform.invokeMethod('disconnectSled');
      connected = msg;
      setState(() {
        connectionStatus = 'Disconnected';
        _connected = connected;
        _scans.clear();
      });
    } on PlatformException catch (e) {
      connected = e.toString();
      print(e);
    }
    fToast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
            color: Color.fromARGB(213, 255, 62, 62),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline_rounded),
              SizedBox(
                width: 6.0,
              ),
              Text("Scanner disconnected.",
                  style: TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
        ),
        positionedToastBuilder: (context, child) {
          return Positioned(child: child, bottom: 10, right: 10);
        },
        toastDuration: Duration(seconds: 1, microseconds: 500));
    // setState(() {
    //   _scans.clear();
    // });
    return;
  }

  Future _scan() async {
    if (isConnected == false) {
      List<String> scans = [];
      fToast.showToast(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.0),
              color: Color.fromARGB(213, 255, 62, 62),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_rounded),
                SizedBox(
                  width: 6.0,
                ),
                Text("Scanner disconnected.",
                    style: TextStyle(fontSize: 12, color: Colors.black87)),
              ],
            ),
          ),
          positionedToastBuilder: (context, child) {
            return Positioned(child: child, bottom: 10, right: 10);
          },
          toastDuration: Duration(seconds: 1, microseconds: 500));
      setState(() {
        _scans = scans;
        print(_scans);
      });
      // on
      return;
    }
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
