library requests;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:productivo/models/asset_model.dart';
import 'dart:isolate';

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

  Future<bool> insertAsset(AssetModel? am) async {
    return true;
  }

  Future<bool> updateAssetWrapper(AssetModel? am) async {
    bool cont = true;
    while (cont) {
      await Future.delayed(Duration(seconds: 2));
      print('trying');
      var snapshot = await updateAsset(am);
      cont = !snapshot;
    }
    return cont;
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
    var body = new Map<String, dynamic>();
    // //check if map exists will fix new item issue
    map.remove('comments');
    map.remove('images');
    body.addAll(map);
    var url = Uri.parse(baseUrl);
    var response;
    try {
      response = await http.post(url, body: map).timeout(Duration(seconds: 2));
    } on SocketException {
      return false;
    }
    if (response.statusCode == 400) {
      throw NullThrownError();
    } else {
      return true;
    }
  }
}
