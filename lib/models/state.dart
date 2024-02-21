import 'package:firebase_auth/firebase_auth.dart';
import 'package:redefineerp/models/settings.dart';
import 'package:redefineerp/models/user.dart';


class StateModel {
  bool isLoading;
  var firebaseUserAuth;
  Bid365User? user;
  Bid365Settings? settings;
  String? locationId, soId, hoId, stId;
  String? locationName, soName, hoName,stName, selPlayAtCategory;



  StateModel({
    this.isLoading = false,
    this.firebaseUserAuth,
    this.user,
    this.settings,
    this.locationId = "0",
    this.locationName="",
    this.selPlayAtCategory = "",
  });
}
