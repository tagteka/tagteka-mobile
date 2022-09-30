import 'package:flutter/material.dart';

import '../components/styles.dart';
import 'dart:isolate';
import '../models/asset_model.dart';
import '../networking/requests.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productivo/pages/scan.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:productivo/pages/edit_comments.dart';

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
  List<DropdownMenuItem<String>> _types = [];
  _EditAssetState(String string, AssetModel? am, bool newItem) {
    str = string;
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
          body: SingleChildScrollView(
            child: _buildForm(),
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

  List<DropdownMenuItem<String>> correspondingTypes(String category) {
    List<DropdownMenuItem<String>> ret = [];
    switch (category) {
      case 'plumbing':
        ret.add(
          DropdownMenuItem(
            child: Text('Valves'),
            value: '0',
          ),
        );
        ret.add(
          DropdownMenuItem(
            child: Text('Pumps'),
            value: '1',
          ),
        );
        ret.add(
          DropdownMenuItem(
            child: Text('Backflow'),
            value: '2',
          ),
        );
        break;
      case 'fireSafety':
        ret.add(
          DropdownMenuItem(
            child: Text('Alarms'),
            value: '0',
          ),
        );
        ret.add(
          DropdownMenuItem(
            child: Text('Circuit Breakers'),
            value: '1',
          ),
        );
        ret.add(
          DropdownMenuItem(
            child: Text('Sprinklers'),
            value: '2',
          ),
        );
        break;
      case 'electrical':
        ret.add(
          DropdownMenuItem(
            child: Text('Motors'),
            value: '0',
          ),
        );
        ret.add(
          DropdownMenuItem(
            child: Text('Batteries'),
            value: '1',
          ),
        );
        ret.add(
          DropdownMenuItem(
            child: Text('Batteries'),
            value: '2',
          ),
        );
        break;
      // case 'electrical':
      //   ret.add(
      //     DropdownMenuItem(
      //       child: Text('Circuit Breakers'),
      //       value: 'circuitBreaker',
      //     ),
      //   );
      //   ret.add(
      //     DropdownMenuItem(
      //       child: Text('Motors'),
      //       value: 'motors',
      //     ),
      //   );
      //   ret.add(
      //     DropdownMenuItem(
      //       child: Text('Batteries'),
      //       value: 'batteries',
      //     ),
      //   );
      //   break;
    }
    return ret;
  }

  // Widget _buildForm() {
  //   final form = FormGroup(
  //     {
  //       'name': FormControl<String>(value: 'John Doe'),
  //       'email': FormControl<String>(),
  //     },
  //   );
  //   return ReactiveForm(
  //       formGroup: form,
  //       child: Column(
  //         children: [
  //           ReactiveTextField(formControlName: 'name'),
  //           ReactiveTextField(
  //             formControlName: 'email',
  //           ),
  //         ],
  //       ));
  // }

  // String _value = "";

  Widget _buildForm() {
    return Form(
      onChanged: () {
        setState(() => {});
      },
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
              style: TextStyle(color: Colors.grey),
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
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text('Plumbing'),
                  value: 'plumbing',
                ),
                DropdownMenuItem(
                  child: Text('Fire Safety'),
                  value: 'fireSafety',
                ),
                DropdownMenuItem(
                  child: Text('HVAC'),
                  value: 'hvac',
                ),
                DropdownMenuItem(
                  child: Text('Electrical'),
                  value: 'electrical',
                ),
                DropdownMenuItem(
                  child: Text('Equipment'),
                  value: 'equipment',
                ),
              ],
              onChanged: (newValue) {
                am!.category = newValue.toString();
                setState(
                  () {
                    _types = correspondingTypes(am!.category);
                  },
                );
              },
              decoration: const InputDecoration(labelText: 'Category'),
              onSaved: (newValue) => am!.category = newValue.toString(),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Select a category';
                }
                return null;
              },
            ),
            _buildSecondDropdown(am), // _formKey.currentState!.reset();

            TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Last Service (YYYY-MM-DD)'),
                onSaved: (newValue) => am!.lastService = newValue == null
                    ? am!.lastService
                    : DateTime.parse(newValue),
                initialValue:
                    newItem ? '' : generateProperDate(am!.lastService),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date.';
                  } else {
                    var pattern1 =
                        r'\^[0-9][0-9][0-9][0-9]-(1[0-2])-[0-3][0-9]$|^[0-9][0-9][0-9][0-9]-0[1-9]-[0-3][0-9]$';
                    RegExp exp = RegExp(pattern1);
                    RegExpMatch? match = exp.firstMatch(value);
                    if (match == null) return 'Does not match pattern.';
                    // print(match![0]);
                  }
                  return null;
                }),

            TextButton(
              child: Text('Edit Comments'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditComments(am: am),
                  ),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
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

  String generateProperDate(DateTime date) {
    String ret = '';
    ret += date.year.toString() + "-";
    if (date.month < 10) ret += '0';
    ret += date.month.toString() + '-';
    if (date.day < 10) ret += '0';
    ret += date.day.toString();
    return ret;
  }

  String indexToType(String i) {
    var type = _types[int.parse(i)].child as Text;
    return type.data!.toLowerCase();
  }

  Widget _buildSecondDropdown(AssetModel? am) {
    return DropdownButtonFormField(
      items: _types,
      onChanged: (newValue) => am!.type = indexToType(newValue.toString()),
      decoration: const InputDecoration(labelText: 'Type'),
      onSaved: (newValue) => am!.type = indexToType(newValue.toString()),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Select a type';
        }
        return null;
      },
    );
    // } else {
    //   return DropdownButtonFormField(
    //     value: '',
    //     items: _types,
    //     onChanged: (newValue) {
    //       am!.type = newValue.toString();
    //       _types = correspondingTypes(am.category);
    //     },
    //     decoration: const InputDecoration(labelText: 'Type'),
    //     onSaved: (newValue) => am!.type = newValue.toString(),
    //     validator: (String? value) {
    //       if (value == null || value.isEmpty) {
    //         return 'Select a type';
    //       }
    //       return null;
    //     },
    //   );
    // }
    // }
  }
}
