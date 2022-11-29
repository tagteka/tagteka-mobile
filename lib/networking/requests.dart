library requests;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:productivo/models/asset_model.dart';
import 'dart:isolate';

class Requests {
  Future<AssetModel?> getAsset(id) async {
    var url = Uri.parse(
        'https://tagteka-test.herokuapp.com/api/findAsset?key=bddad5c9fc6b2036856cabb953481774d7709106ff5dfd98a5da0ce818304b8c&id=' +
            id.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      AssetModel _model2 = AssetModel(
        id: "NLP-00001",
        avatar:
            "https://tagteka-assets.s3.us-east-2.amazonaws.com/extinguisher.jpeg",
        category: "Fire",
        comments: ["Been checked twice looks good."],
        dateInstalled: "Thu, 15 Sep 2022 15:28:39 GMT",
        lastService: DateTime.parse("2022-09-01"),
        location: "Storage Room",
        model: "WBDL-ABC310LV",
        name: "Fire Extinguisher",
        nextServiceDate: ["Sun, 30 Apr 2023 00:00:00 GMT"],
        owner: "ray@tagteka.com",
        serial: "",
        assetModelId: 1,
        servicingRecords: [
          "Mon, 30 Apr 2018 00:00:00 GMT",
          "Tue, 30 Apr 2019 00:00:00 GMT",
          "Thu, 30 Apr 2020 00:00:00 GMT",
          "Fri, 30 Apr 2021 00:00:00 GMT",
          "Sat, 30 Apr 2022 00:00:00 GMT"
        ],
        size: "2",
        tagId: "4E4C502D3030303031000700",
        temp: "-99",
        type: "Extinguisher",
      );
      print(response.body);
      print(_model2.toJson());
      AssetModel _model = assetModelFromJson(response.body);
      print(_model);
      return _model;
    } else {
      print('not returning');
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

  Future<bool> updateCommentsWrapper(AssetModel? am) async {
    bool cont = true;
    while (cont) {
      await Future.delayed(Duration(milliseconds: 500));
      print('trying comment update');
      var snapshot = await (updateComments(am));
      cont = !snapshot;
    }
    return cont;
  }

  Future<bool> updateComments(AssetModel? am) async {
    var baseUrl = 'https://tagteka-test.herokuapp.com/api/setComments?id=' +
        am!.id +
        '&' +
        'key=e3e77702408077f5a199a080c65b95ea6dd63205e7bd2c2c65a07195c0d14d16';
    var body = new Map<String, dynamic>();
    // body['comments'] = am.comments;
    body['_id'] = am.id;
    var newBody = json.encode(body);
    print(newBody);
    var url = Uri.parse(baseUrl);
    var response;
    try {
      response = await http.post(url, body: newBody, headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      }).timeout(Duration(milliseconds: 500));
    } on SocketException {
      return false;
    }
    if (response.statusCode == 400) {
      throw NullThrownError();
    } else
      return true;
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
      response =
          await http.post(url, body: map).timeout(Duration(milliseconds: 500));
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
