library requests;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:productivo/models/asset_model.dart';

class Requests {
  Future<AssetModel?> getAsset(id) async {
    var url = Uri.parse(
        'https://tagteka-test.herokuapp.com/api/findAsset?key=e3e77702408077f5a199a080c65b95ea6dd63205e7bd2c2c65a07195c0d14d16&id=' +
            id.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      if (response.body == 'ERROR')
        throw NullThrownError();
      else {
        AssetModel _model = assetModelFromJson(response.body);
        return _model;
      }
    } else {
      throw NullThrownError();
    }
  }

  Future<bool> updateAsset(AssetModel? am) async {
    // String baseUrl =
    //     'https://tagteka-test.herokuapp.com/api/updateAsset?key=e3e77702408077f5a199a080c65b95ea6dd63205e7bd2c2c65a07195c0d14d16&id=' +
    //         am!.id;
    // Map<String, dynamic> map = am.toJson();
    // List<String> keys = map.keys.toList();
    // keys.map(
    //   (e) {
    //     if (e == '_id') {
    //       baseUrl += '&id';
    //     } else if(e == 'comments' || e == '')
    //     else {
    //       baseUrl += '&' + e + '=' + map[e].toString();
    //     }
    //   },
    // ).toList();
    // print(baseUrl);
    var baseUrl =
        'https://tagteka-test.herokuapp.com/api/updateAsset?key=e3e77702408077f5a199a080c65b95ea6dd63205e7bd2c2c65a07195c0d14d16';
    var map = am!.toJson();
    var keys = map.keys.toList();
    var body = new Map<String, dynamic>();
    //check if map exists will fix new item issue
    map.remove('comments');
    map.remove('images');
    body.addAll(map);
    var url = Uri.parse(baseUrl);
    final response = await http.post(url, body: map);
    print(response);
    if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: 'Error, DB not updated.',
        textColor: Colors.white,
        backgroundColor: Colors.red,
      );
      throw NullThrownError();
    } else {
      Fluttertoast.showToast(
        msg: 'Success, DB updated!',
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
      return true;
    }
  }
}
