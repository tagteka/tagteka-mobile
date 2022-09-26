// To parse this JSON data, do
//
//     final assetModel = assetModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AssetModel assetModelFromJson(String str) =>
    AssetModel.fromJson(json.decode(str));

String assetModelToJson(AssetModel data) => json.encode(data.toJson());

class AssetModel {
  AssetModel({
    required this.id,
    required this.category,
    required this.comments,
    required this.date,
    required this.images,
    required this.lastService,
    required this.name,
    required this.tagtekaId,
    required this.type,
  });

  String id;
  String category;
  List<String> comments;
  DateTime date;
  List<String> images;
  DateTime lastService;
  String name;
  String tagtekaId;
  String type;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        id: json["_id"],
        category: json["category"],
        comments: List<String>.from(json["comments"].map((x) => x)),
        date: DateTime.parse(json["date"]),
        images: List<String>.from(json["images"].map((x) => x)),
        lastService: DateTime.parse(json["lastService"]),
        name: json["name"],
        tagtekaId: json["tagtekaId"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "images": List<dynamic>.from(images.map((x) => x)),
        "lastService":
            "${lastService.year.toString().padLeft(4, '0')}-${lastService.month.toString().padLeft(2, '0')}-${lastService.day.toString().padLeft(2, '0')}",
        "name": name,
        "tagtekaId": tagtekaId,
        "type": type,
      };
}
