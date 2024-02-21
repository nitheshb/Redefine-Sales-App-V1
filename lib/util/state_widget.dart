import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:redefineerp/models/settings.dart';
import 'package:redefineerp/models/state.dart';
import 'package:redefineerp/models/user.dart';
import 'package:redefineerp/util/auth.dart';

class StateWidget extends StatefulWidget {
  final StateModel state;
  final Widget child;

  StateWidget({
    required this.child,
    required this.state,
  });

  // Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static _StateWidgetState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_StateDataWidget>()
            as _StateDataWidget)
        .data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  StateModel? state;
  //GoogleSignInAccount googleAccount;
  //final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }

  Future<Null> initUser() async {
    //print('...initUser...');
    var firebaseUserAuth = await Auth.getCurrentFirebaseUser();
    Bid365User user = await Auth.getUserLocal();
    // Bid365Settings settings = await Auth.getSettingsLocal();
   

    setState(() {
      state?.isLoading = false;
      state?.firebaseUserAuth = firebaseUserAuth;
      state?.user = user;
      // state?.settings = settings;
  
    });
  }





  // Future<void> logOutUser() async {
  //   await Auth.signOut();
  //   var firebaseUserAuth = await Auth.getCurrentFirebaseUser();
  //   setState(() {
  //     state.user = null;
  //     state.settings = null;
  //     state.firebaseUserAuth = firebaseUserAuth;
  //   });
  // }

  // Future<void> resetPassword(email) async {
  //   await Auth.forgetPassword(email);
  // }

  Future<void> logInUser(email, password) async {
    String userId = await Auth.signIn(email, password);
    print('am i called');
    Bid365User user = await Auth.getUserFirestore(userId);

    // await Auth.getAndUpdateFcmToken(user, userId);
    // await Auth.storeUserLocal(user);
    // Bid365Settings settings = await Auth.getSettingsFirestore(userId);
    // await Auth.storeSettingsLocal(settings);
    await initUser();
  }

localSaverTest(user,userId ) async {
      await Auth.storeUserLocal(user);
    // Bid365Settings settings = await Auth.getSettingsFirestore(userId);
    // await Auth.storeSettingsLocal(settings);
    await initUser();
}
  Future<void> fbLoginStoreUser(userId) async {
    Bid365User user = await Auth.getUserFirestore(userId);
    print('user is ${user}');
    await Auth.storeUserLocal(user);
    Bid365Settings settings = await Auth.getSettingsFirestore(userId);
    await Auth.storeSettingsLocal(settings);
    await initUser();
  }

  @override
  Widget build(BuildContext context) {
    return new _StateDataWidget(
      data: this,
  
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}
