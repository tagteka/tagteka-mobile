/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import '../components/styles.dart';
import 'package:productivo/networking/requests.dart';
import 'package:productivo/models/asset_model.dart';

class ScanDetail extends StatelessWidget {
  static const String id = 'ScanDetail';
  final String string;

  const ScanDetail({Key? key, required this.string}) : super(key: key);
  // @override
  // _ScanDetailState createState() => _ScanDetailState();

// class _ScanDetailState extends State<ScanDetail> {
//   @override
//   void initState() {
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text('Asset Details'),
        actions: [
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appColor),
            ),
            child: Text("Edit".toUpperCase(),
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              color: Colors.white,
              child: Stack(
                children: [
                  FutureBuilder(
                      future: Requests().getAsset(string),
                      builder: (context, AsyncSnapshot<AssetModel?> snapshot) {
                        List<String> currentDetails = [];
                        if (snapshot.hasData) {
                          currentDetails.add(snapshot.data!.name);
                          currentDetails.add(snapshot.data!.tagtekaId);
                          currentDetails.add(snapshot.data!.id);
                          currentDetails.add(snapshot.data!.date);
                          currentDetails.add(snapshot.data!.lastService);
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.black12),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: currentDetails
                                  .map(
                                    (e) => InkWell(
                                      child: _buildAssetdtl(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.black12),
                              )));
                        } else {
                          return SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      color: appColor,
      height: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Look Up in The Sky",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontFamily: "medium"),
          ),
          // SizedBox(height: 10),
          // Row(
          //   children: [
          //     chips('Lorem'),
          //     chips('Lorem'),
          //   ],
          // ),
        ],
      ),
    );
  }

  chips(txt) {
    return Container(
      padding: EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          txt.toUpperCase(),
          style: TextStyle(color: appColor, fontSize: 10),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildAssetdtl(String detail) {
    return Container(
      child: Text('$detail'),
    );
  }
}
