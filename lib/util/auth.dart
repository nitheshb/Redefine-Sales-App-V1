import 'dart:async';
//import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:redefineerp/helpers/firebase_help.dart';
import 'package:redefineerp/models/settings.dart';
import 'package:redefineerp/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {
  static Future<String> signUp(String email, String password) async {
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return user.user!.uid;
  }

  // static addUserSettingsDB(context, Bid365User user) async {
  //   checkUserExist(user.userId).then((value) async {
  //     if (!value) {
  //       print(
  //           "user ${user.firstName} ${user.email} ${user.userId} added with referral code ${user.referralCode} with wallet ${user.walletMoney} ");

  //       String emails = user.email;

  //       //  generate first 3 letters and find number of people has it
  //       String emailFil = emails.replaceAll(new RegExp('='), '');
  //       var referString = emails.substring(0, 3);
  //       print('email setup is ${emailFil[0]}');

  //       var d =
  //           await DbQuery.instanace.updateReferalIdCount('RDX${referString}');

  //       var userId = await FirebaseFirestore.instance
  //           .doc("users/${user.userId}")
  //           .set(user.toJson());

  //       // StateWidget.of(context).fbLoginStoreUser(FirebaseAuth.instance.currentUser);
  //       var docs = await FirebaseFirestore.instance
  //           .collection('users')
  //           .where("email", isEqualTo: emails)
  //           .get();

  //       if (!docs.docs.isEmpty) {
  //         // String docId = await docs.docs[0]["userId"];
  //         var myReferCode = await 'RDX${d}U';
  //         var referredBy =
  //             await DbQuery.instanace.getReferedUserDetails(user.referralCode);
  //         print('===>referred BY ${referredBy}');
  //         if (referredBy == null) {
  //           referredBy = "NA";
  //         } else {
  //           await FirebaseFirestore.instance.doc("users/${referredBy}").update({
  //             'referC': FieldValue.increment(1),
  //             'walletMoney': FieldValue.increment(50)
  //           });
  //           await DbQuery.instanace.createTransactionLog('referal Bonus', (50),
  //               referredBy, {'referralId': user.email}, 0, 0, 0);
  //         }
  //         print('docns check is ${docs.docs[0].data()}');
  //         var data = docs.docs[0].data();
  //         await FirebaseFirestore.instance.doc("users/${user.userId}").update({
  //           'walletMoney': (data["walletMoney"] + 50),
  //           'myRCode': myReferCode,
  //           'rBy': referredBy
  //         });
  //         await DbQuery.instanace.createTransactionLog(
  //             'Join Bonus', (100), user.userId, {}, 0, 0, 0);

  //         // await print("query data is ${docId}");
  //       } else {
  //         print("referral email id not found");
  //       }
  //       _addSettings(new Bid365Settings(
  //         settingsId: user.userId,
  //       ));
  //     } else {
  //       print("user ${user.firstName} ${user.email} exists");
  //     }
  //   });
  // }

  static Future<bool> checkUserExist(String userId) async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance.doc("users/$userId").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static void _addSettings(Bid365Settings settings) async {
    FirebaseFirestore.instance
        .doc("settings/${settings.settingsId}")
        .set(settings.toJson());
  }

  static Future<String> signIn(String email, String password) async {
    var user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user.user!.uid;
  }

  static Future<void> forgetPassword(
    String email,
  ) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // AuthResult user = await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static  getUserFirestore(userId) async {
    if (userId != null) {
      var x;
      try {
        print('iam here1 ${x}');
        x = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get()
            .then((documentSnapshot) =>
                Bid365User.fromDocument(documentSnapshot));
                Auth.storeUserLocal(x);
        print('iam here ${x}');
        return x;
      } catch (e) {
        print('error at auth sign in  ${e}');
      }
    } else {
      print('firestore userId can not be null');

      return null;
    }
  }

  static getSettingsFirestore(String settingsId) async {
    if (settingsId != null) {
      return FirebaseFirestore.instance
          .collection('settings')
          .doc(settingsId)
          .get()
          .then((documentSnapshot) =>
              Bid365Settings.fromDocument(documentSnapshot));
    } else {
      print('no firestore settings available');
      return null;
    }
  }



  static Future<String> storeUserLocal(Bid365User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = userToJson(user);
    await prefs.setString('user', storeUser);
    print('store local stuff is ${storeUser}');
    return user.uId;
  }

  static localSaveDispName(dispName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('dispName', dispName);

    return dispName;
  }

  static Future<String> storeUserLocationLocal(
      String user, locationId, soId, soName, hoId, hoName, stId, stName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = (user);
    await prefs.setString('locationName', storeUser);
    await prefs.setString('locationId', locationId);
    await prefs.setString('soId', soId);
    await prefs.setString('soName', soName);
    await prefs.setString('hoId', hoId);
    await prefs.setString('hoName', hoName);
    await prefs.setString('stId', stId);
    await prefs.setString('stName', stName);
    return user;
  }

  static Future<String> setSelPlayAtCategoryLocal(
      selPlayAtCategoryLocal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selPlayAtCategory', selPlayAtCategoryLocal);
    return selPlayAtCategoryLocal;
  }

  static Future<String> storeSettingsLocal(settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String storeSettings = settingsToJson(settings);
    // await prefs.setString('settings', settings);
    print('check for this value ${settings}');
    return settings.settingsId;
  }

  static Future getCurrentFirebaseUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser;
  }

  static  getUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('USER outside');
    if (prefs.getString('user') != null) {
      Bid365User user = userFromJson(prefs.getString('user'));
      print('USER: $user');
      return user;
    } else {
      print('USER: null');
      return null;
    }
  }





  



  // static Future<Bid365Settings> getSettingsLocal() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('settings') != null) {
  //     Bid365Settings settings = settingsFromJson(prefs.getString('settings'));
  //     //print('SETTINGS: $settings');
  //     return settings;
  //   } else {
  //     return null;
  //   }
  // }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  static Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static String getExceptionText(Exception e) {
    // if (e is PlatformException) {
    print('--> value1 is ${e.toString()}');

    switch (e.toString()) {
      case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
        return 'User with this email Id not found.';
        break;
      case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
        return 'Invalid password.';
        break;
      case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
        return 'No internet connection.';
        break;
      case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
        return 'This email address already in use';
        break;
      default:
        return '${e}';
    }
    // } else {
    //    print('--> value is ${e}');
    //   return 'Unknown error occured.';
    // }
  }

  /*static Stream<Bid365User> getUserFirestore(String userId) {
    print("...getUserFirestore...");
    if (userId != null) {
      //try firestore
      return FirebaseFirestore.instance
          .collection("users")
          .where("userId", isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        return snapshot.docs.map((doc) {
          return Bid365User.fromDocument(doc);
        }).first;
      });
    } else {
      print('firestore user not found');
      return null;
    }
  }*/

  /*static Stream<Bid365Settings> getSettingsFirestore(String settingsId) {
    print("...getSettingsFirestore...");
    if (settingsId != null) {
      //try firestore
      return FirebaseFirestore.instance
          .collection("settings")
          .where("settingsId", isEqualTo: settingsId)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        return snapshot.docs.map((doc) {
          return Bid365Settings.fromDocument(doc);
        }).first;
      });
    } else {
      print('no firestore settings available');
      return null;
    }
  }*/
}
