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
import 'package:carousel_slider/carousel_slider.dart';

class ScanDetail extends StatefulWidget {
  static const String id = 'ScanDetail';
  final String string;

  const ScanDetail({Key? key, required this.string}) : super(key: key);
  @override
  _ScanDetailState createState() => _ScanDetailState(string);
}

class _ScanDetailState extends State<ScanDetail> {
  String str = "";
  @override
  void initState() {
    super.initState();
  }

  _ScanDetailState(string) {
    this.str = string;
  }

  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;
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
                      future: Requests().getAsset(str),
                      builder: (context, AsyncSnapshot<AssetModel?> snapshot) {
                        List<String> currentDetails = [];
                        List<String> urls = [];
                        List<String> comments = [];
                        if (snapshot.hasData) {
                          currentDetails.add("Name: " + snapshot.data!.name);
                          currentDetails
                              .add("TTid: " + snapshot.data!.tagtekaId);
                          currentDetails.add("Type: " + snapshot.data!.type);
                          currentDetails.add("Last service: " +
                              snapshot.data!.lastService.toString());
                          currentDetails.add("id: " + snapshot.data!.id);
                          currentDetails
                              .add('Date: ' + snapshot.data!.date.toString());
                          comments.addAll(snapshot.data!.comments);
                          urls.addAll(snapshot.data!.images);

                          return Column(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(height: 300.0),
                                items: urls.map((i) {
                                  return Builder(
                                      builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Image.network('$i'));
                                  });
                                }).toList(),
                              ),
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: Colors.black12),
                                    left: BorderSide(
                                        width: 1.0, color: Colors.black12),
                                    right: BorderSide(
                                        width: 1.0, color: Colors.black12),
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.black12),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: merge(
                                      currentDetails
                                          .map((e) => (_buildAssetdtl(e)))
                                          .toList(),
                                      (comments
                                          .map((e) => Text("$e"))
                                          .toList())),
                                ),
                              ),
                              TextButton(
                                onPressed: () => {},
                                child: Text('Request Service'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all(appColor),
                                ),
                              ),
                            ],
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

  List<Widget> merge(List<Widget> list1, List<Widget> other) {
    List<Widget> w = [];
    w.addAll(list1);
    w.addAll(other);
    return w;
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
    return Text('$detail');
  }
}
