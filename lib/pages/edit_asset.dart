import 'package:flutter/material.dart';

import '../components/styles.dart';
import 'dart:isolate';
import '../models/asset_model.dart';
import '../networking/requests.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productivo/pages/scan.dart';

class EditAsset extends StatefulWidget {
  static const String id = 'EditAsset';
  // final String title;
  final String str;
  final AssetModel? assetModel;
  final bool newItem;

  const EditAsset(
      {Key? key, required this.str, this.assetModel, required this.newItem})
      : super(key: key);

  @override
  _EditAssetState createState() => _EditAssetState(str, assetModel, newItem);
}

class _EditAssetState extends State<EditAsset> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String result = '';
  String str = '';
  AssetModel? am;
  bool newItem = false;
  String title = 'Edit an existing item.';

  _EditAssetState(String string, AssetModel? am, bool newItem) {
    this.am = newItem
        ? new AssetModel(
            id: str,
            category: '',
            comments: [],
            date: DateTime.now(),
            images: [],
            lastService: DateTime.now(),
            name: '',
            tagtekaId: '',
            type: '')
        : am;
    print(this.am!.id);
    str = string;
    this.newItem = newItem;
    title = newItem ? 'Add a New Asset' : 'Edit Asset';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // Navigator.of(context).dispose();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Scan()),
                  ModalRoute.withName('Scan'),
                );
              },
            ),
            backgroundColor: appColor,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            title: Text(title),
            actions: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: appColor,
                ),
                child: Text("Save".toUpperCase()),
              ),
            ],
          ),
          body: Column(
            children: [
              _buildForm(),
            ],
          )
          // body: SingleChildScrollView(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[],
          //   ),
          // ),
          ),
    );
  }

  Future<void> isolateFn(AssetModel? am) async {
    final ReceivePort p = ReceivePort();
    Isolate.exit(p.sendPort, await Requests().updateAssetWrapper(am));
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Asset ID',
              ),
              readOnly: true,
              enabled: false,
              initialValue: am!.id,
            ),
            TextFormField(
                decoration: const InputDecoration(labelText: 'Asset Name'),
                onSaved: (newValue) =>
                    am!.name = newValue == null ? am!.name : newValue,
                initialValue: newItem ? '' : am!.name,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an asset name';
                  }
                  return null;
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (!newItem) {
                      Isolate.spawn(
                        Requests().updateAssetWrapper,
                        am,
                      );
                      // Requests().updateAsset(am);
                    } else
                      Requests().insertAsset(am);
                    setState(() {});
                  }
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
