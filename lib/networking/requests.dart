library requests;

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
}
