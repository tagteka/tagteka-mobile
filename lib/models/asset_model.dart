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
    required this.type,
    this.model,
    this.serial,
    this.size,
    this.temp,
    required this.location,
    required this.owner,
    this.dateInstalled,
    this.servicingRecords,
    this.nextServiceDate,
    this.comments,
    required this.category,
    this.assetModelId,
    required this.name,
    required this.avatar,
    required this.tagId,
    this.lastService,
  });

  String id;
  String type;
  String? model;
  String? serial;
  String? size;
  String? temp;
  String location;
  String owner;
  String? dateInstalled;
  List<String>? servicingRecords;
  List<String>? nextServiceDate;
  List<String>? comments;
  String category;
  int? assetModelId;
  String name;
  String avatar;
  String tagId;
  DateTime? lastService;

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
        id: json["_id"] == null ? null : json["_id"],
        type: json["type"] == null ? null : json["type"],
        model: json["model"] == null ? null : json["model"],
        serial: json["serial"] == null ? null : json["serial"],
        size: json["size"] == null ? null : json["size"],
        temp: json["temp"] == null ? null : json["temp"],
        location: json["location"] == null ? null : json["location"],
        owner: json["owner"] == null ? null : json["owner"],
        dateInstalled:
            json["dateInstalled"] == null ? null : json["dateInstalled"],
        servicingRecords: json["servicingRecords"] == null
            ? null
            : List<String>.from(json["servicingRecords"].map((x) => x)),
        nextServiceDate: json["nextServiceDate"] == null
            ? null
            : List<String>.from(json["nextServiceDate"].map((x) => x)),
        comments: json["comments"] == null
            ? null
            : List<String>.from(json["comments"].map((x) => x)),
        category: json["category"] == null ? null : json["category"],
        assetModelId: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        tagId: json["tagID"] == null ? null : json["tagID"],
        lastService: json["lastService"] == null
            ? null
            : DateTime.parse(json["lastService"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "type": type == null ? null : type,
        "model": model == null ? null : model,
        "serial": serial == null ? null : serial,
        "size": size == null ? null : size,
        "temp": temp == null ? null : temp,
        "location": location == null ? null : location,
        "owner": owner == null ? null : owner,
        "dateInstalled": dateInstalled == null ? null : dateInstalled,
        "servicingRecords": servicingRecords == null
            ? null
            : List<dynamic>.from(servicingRecords!.map((x) => x)),
        "nextServiceDate": nextServiceDate == null
            ? null
            : List<dynamic>.from(nextServiceDate!.map((x) => x)),
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments!.map((x) => x)),
        "category": category == null ? null : category,
        "id": assetModelId == null ? null : assetModelId,
        "name": name,
        "avatar": avatar == null ? null : avatar,
        "tagID": tagId == null ? null : tagId,
        "lastService": lastService == null
            ? null
            : "${lastService!.year.toString().padLeft(4, '0')}-${lastService!.month.toString().padLeft(2, '0')}-${lastService!.day.toString().padLeft(2, '0')}",
      };
}
