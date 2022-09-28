import 'package:flutter/material.dart';

import '../components/styles.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../models/asset_model.dart';

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
    this.am = am;
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
        body: _buildForm(),
        // body: SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[],
        //   ),
        // ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              decoration: InputDecoration(
                  hintText: (this.newItem ? 'Enter the Asset Name' : am!.name)),
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
                if (_formKey.currentState!.validate()) {}
              },
              child: const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
