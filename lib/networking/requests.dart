library requests;

import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:productivo/models/asset_model.dart';

class Requests {
  Future<AssetModel?> getAsset(id) async {
    try {
      var url = Uri.parse(
          'https://tagteka-test.herokuapp.com/api/findAsset?id=' +
              id.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        AssetModel _model = assetModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
