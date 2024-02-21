import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);

Bid365Settings settingsFromJson(String str) {
  final jsonData = json.decode(str);
  return Bid365Settings.fromJson(jsonData);
}

String settingsToJson(Bid365Settings data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Bid365Settings {
  String? settingsId;

  Bid365Settings({
    this.settingsId,
  });

  factory Bid365Settings.fromJson(json) => new Bid365Settings(
        settingsId: json["settingsId"],
      );

  Map<String, dynamic> toJson() => {
        "settingsId": settingsId,
      };

  factory Bid365Settings.fromDocument(DocumentSnapshot doc) {
    return Bid365Settings.fromJson(doc.data());
  }
}
