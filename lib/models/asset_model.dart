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
  });

  String id;
  String date;
  String name;
  String type;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        id: json["_id"] == null ? null : json["_id"],
        date: json["date"] == null ? null : json["date"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "date": date == null ? null : date,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
      };
}
