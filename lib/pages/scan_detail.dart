/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'dart:io';
import '../components/styles.dart';
import 'package:productivo/networking/requests.dart';
import 'package:productivo/models/asset_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:productivo/pages/edit_asset.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';

class ScanDetail extends StatefulWidget {
  static const String id = 'ScanDetail';
  final AssetModel? am;

  const ScanDetail({Key? key, required this.am}) : super(key: key);
  @override
  _ScanDetailState createState() => _ScanDetailState(am);
}

class _ScanDetailState extends State<ScanDetail> {
  AssetModel? am;
  @override
  void initState() {
    super.initState();
  }

  _ScanDetailState(am) {
    this.am = am;
  }

  final photos = <File>[];

  void openCamera() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CameraCamera(
                  onFile: (file) {
                    photos.add(file);
                    Navigator.pop(context);
                    setState(() {});
                  },
                )));
  }

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAsset(
                    str: am!.id,
                    assetModel: am,
                    newItem: false,
                  ),
                ),
              );
            },
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

  List<Widget> _buildImages(size) {
    List<Widget> ret = [];
    photos.forEach((element) {
      ret.add(Container(
        child: Image.file(element, fit: BoxFit.cover),
        width: size.width,
      ));
    });
    return ret;
  }

  List<Widget> merge(List<Widget> a, List<Widget> b) {
    List<Widget> c = [];
    c.addAll(a);
    c.addAll(b);
    return c;
  }

  Widget _buildBody() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Stack(
                children: merge([
              _buildData(),
              IconButton(
                icon: Icon(Icons.camera),
                onPressed: openCamera,
              ),
            ], _buildImages(size))),
          ),
        ],
      ),
    );
  }

  _buildData() {
    List<String> currentDetails = [];
    List<String> urls = [];
    List<String> comments = [];
    currentDetails.add("Name: " + am!.name);
    currentDetails.add("TTid: " + am!.tagId);
    currentDetails.add("Type: " + am!.type);
    currentDetails.add("Last service: " + am!.lastService.toString());
    currentDetails.add("id: " + am!.id);
    currentDetails.add('Date: ' + am!.dateInstalled.toString());
    comments.addAll(am!.comments!.toList());
    // urls.addAll(am!.images);

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 300.0),
          items: urls.map((i) {
            return Builder(builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image.network('$i'));
            });
          }).toList(),
        ),
        SizedBox(height: 30),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.black12),
              left: BorderSide(width: 1.0, color: Colors.black12),
              right: BorderSide(width: 1.0, color: Colors.black12),
              bottom: BorderSide(width: 1.0, color: Colors.black12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _merge(
                currentDetails.map((e) => (_buildAssetdtl(e))).toList(),
                (comments.map((e) => Text("$e")).toList())),
          ),
        ),
        TextButton(
          onPressed: () => {},
          child: Text('Request Service'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(appColor),
          ),
        ),
      ],
    );
  }
}

List<Widget> _merge(List<Widget> list1, List<Widget> other) {
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
