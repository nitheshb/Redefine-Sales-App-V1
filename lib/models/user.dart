import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

Bid365User userFromJson( str) {
  final jsonData = json.decode(str);
  return Bid365User.fromJson(jsonData);
}

String userToJson(Bid365User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Bid365User {
  String uId;
  String dispName;
  String orgId;
  String email;


  Bid365User(
      {required this.uId,
      required this.dispName,
      required this.orgId,
      required this.email,
});

  factory Bid365User.fromJson( json) => new Bid365User(
      uId: json["uId"],
      dispName: json['dispName'],
      orgId: json["orgId"],
      email: json["email"],
 
      );

  Map<String, dynamic> toJson() => {
        "uId": uId,
        "dispName": dispName,
        "orgId": orgId,
        "email": email,
 
      };

  factory Bid365User.fromDocument(DocumentSnapshot doc) {
    print('it is reached here ${doc.data()}');
    return Bid365User.fromJson(doc.data());
  }
}
