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

List<String> currentDetails = [];

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
    _getDetails(string);
    _getDetails(string);
    print(currentDetails);
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
    _getDetails(string);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: currentDetails
                        .map(
                          (e) => InkWell(
                            child: _buildAssetdtl(e),
                          ),
                        )
                        .toList(),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void _getDetails(string) async {
    AssetModel? response;
    response = await Requests().getAsset(string);
    List<String> details = [];
    details.add(response!.tagtekaId);
    details.add(response.name);
    details.add(response.id);
    details.add(response.lastService);
    details.add(response.date);
    details.add(response.type);

    currentDetails.clear();
    currentDetails.addAll(details);
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
