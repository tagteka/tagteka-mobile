// To parse this JSON data, do
//
//     final assetModel = assetModelFromJson(jsonString);

import 'dart:convert';

AssetModel assetModelFromJson(String str) =>
    AssetModel.fromJson(json.decode(str));

String assetModelToJson(AssetModel data) => json.encode(data.toJson());

class AssetModel {
  AssetModel({
    required this.id,
    required this.date,
    required this.name,
    required this.type,
    required this.tagtekaId,
    required this.lastService,
  });

  String id;
  String date;
  String name;
  String type;
  String tagtekaId;
  String lastService;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        id: json["_id"] == null ? null : json["_id"],
        date: json["date"] == null ? null : json["date"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        tagtekaId: json["tagtekaId"] == null ? null : json["tagtekaId"],
        lastService: json["lastService"] == null ? null : json["lastService"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date,
        "name": name,
        "type": type,
        "tagtekaId": tagtekaId,
        "lastService": lastService,
      };
}
