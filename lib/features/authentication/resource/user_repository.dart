import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:youtube_app_bloc/common/model/user.dart' as u;
import 'package:youtube_app_bloc/common/utils/shared_pref.dart';
import 'package:youtube_app_bloc/features/authentication/model/data_response.dart';

class UserRepository {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  ValueNotifier<u.User?> user = ValueNotifier(null);
  fetchInitialState() {}
  Future<DataResponse> loginWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      await _googleSignIn.signOut();
      final _googleUser = await _googleSignIn.signIn();
      if (_googleUser != null) {
        user.value = u.User(
          id: "",
          name: _googleUser.displayName ?? "",
          email: _googleUser.email,
        );
        SharedPref.setUser(user.value!);
        _isLoggedIn = true;
      } else {
        return DataResponse.error(message: "Unable to login with google");
      }

      return DataResponse.sucess(data: true);
    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }

  Future<DataResponse> loginWitheEmailPassword(
      {required String email, required String password}) async {
    try {
      FirebaseAuth.instance.signOut();

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      user.value = u.User(
        id: "",
        name: userCredential.user?.displayName ?? "",
        email: userCredential.user?.email ?? "",
      );
      SharedPref.setUser(user.value!);
      _isLoggedIn = true;

      return DataResponse.sucess(data: true);
    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }

  Future<DataResponse> signUpWitheEmailPassword(
      {required String email, required String password}) async {
    try {
      FirebaseAuth.instance.signOut();

      final _res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(_res.user?.email);
      return DataResponse.sucess(data: true);
    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }

  Future<DataResponse> loginWithFacebook() async {
    try {
      await fb.FacebookAuth.instance.logOut();
      final fb.LoginResult result = await fb.FacebookAuth.instance
          .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
      if (result.status == fb.LoginStatus.success) {
        // you are logged
        final fb.AccessToken accessToken = result.accessToken!;
        final userData = await fb.FacebookAuth.instance.getUserData();
        print(userData);
        user.value = u.User(
          id: "",
          name: userData["name"],
          email: userData["email"],
        );
        SharedPref.setUser(user.value!);
        _isLoggedIn = true;

        return DataResponse.sucess(data: true);
      } else {
        DataResponse.error(
            message: result.message ?? "Unable to login with facebook");
        print(result.status);
        print(result.message);
      }

      return DataResponse.sucess(data: true);
    } catch (e) {
      return DataResponse.error(message: e.toString());
    }
  }
}
