import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

import 'db.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  final DBService db = DBService();
  String _verificationID;
  AuthCredential _phoneCred;
  AuthCredential _emailCred;

  Stream<User> currentUser = FirebaseAuth.instance.userChanges();

  /// [Login with email and password]
  Future<String> signInWithEmail(String email, String pass,
      [bool admin = false]) async {
    assert(email.isNotEmpty && pass.isNotEmpty);
    print('$email, $pass');
    String msg = '';
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      await updateDB();
    } on FirebaseAuthException catch (e) {
      log('$e');
      Get.rawSnackbar(title: 'Something Went Wrong!', message: '${e.code}');
    }
    return msg;
  }

  /// [Sign up with email and password]
  Future<void> signUpWithEmail({String email, String password}) async {
    try {
      _emailCred =
          EmailAuthProvider.credential(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log('$e');
      Get.rawSnackbar(
          title: 'Something Went Wrong!',
          message: '$e',
          duration: Duration(seconds: 5));
    }
  }

  /// [Google Sign in]
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    await updateDB();
  }

  /// [Request OTP from user]
  Future<void> requestOtpUsingPhoneNumber(String phone) async {
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationID = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationID = verificationId;
    };
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await auth.signInWithCredential(phoneAuthCredential);
      print(
          "Phone number automatically verified and user signed in: ${auth.currentUser.uid}");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(seconds: 120),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      log('Error: $e');
      Get.rawSnackbar(
          title: 'Error', message: '$e', duration: Duration(seconds: 5));
    }
  }

  /// [Update Current Users phone number]
  Future<void> updatePhoneNumber(String smsCode) async {
    User user;
    try {
      AuthCredential authCred = PhoneAuthProvider.credential(
          verificationId: _verificationID, smsCode: smsCode);
      _phoneCred = authCred;
      await auth.currentUser.updatePhoneNumber(_phoneCred);
    } on FirebaseAuthException catch (e) {
      Get.rawSnackbar(
          title: 'Error', message: '$e', duration: Duration(seconds: 5));
    }
    return user;
  }

  /// [Sign in completion using otp]
  Future<User> signInWithOtp(String smsCode) async {
    User user;
    try {
      AuthCredential authCred = PhoneAuthProvider.credential(
          verificationId: _verificationID, smsCode: smsCode);
      _phoneCred = authCred;
      user = (await FirebaseAuth.instance.signInWithCredential(authCred)).user;

      print('User After Sign in With OTP: $user');
    } catch (e) {
      Get.rawSnackbar(
          title: 'Error', message: '$e', duration: Duration(seconds: 5));
    }
    return user;
  }

  /// [Registering a User]
  Future<void> registerUser({
    String name,
    String email,
    String password,
    String image,
  }) async {
    try {
      await signUpWithEmail(email: email, password: password);
      final currentUser = auth.currentUser;

      await currentUser.linkWithCredential(_emailCred);
      await currentUser.reload();
      print('User after linking: $currentUser');

      await currentUser.updateProfile(displayName: name, photoURL: image);
      await currentUser.reload();
      print('User after profile update: $currentUser');
      await updateDB();
    } catch (e) {
      log('$e');
      Get.rawSnackbar(
          title: 'Error', message: '$e', duration: Duration(seconds: 5));
    }
  }

  /// [Update values in database]
  Future<void> updateDB() async {
    try {
      await auth.currentUser.reload();
      await db.upsert('users/${auth.currentUser.uid}', {
        "email": auth.currentUser.email,
        "uid": auth.currentUser.uid,
        "name": auth.currentUser.displayName,
        "image": auth.currentUser.photoURL,
        "phone": auth.currentUser.phoneNumber,
        "lastLogin": DateTime.now().toString()
      });
    } catch (e) {
      log('$e');
      Get.rawSnackbar(
          title: 'Error', message: '$e', duration: Duration(seconds: 5));
    }
  }

  ///[Update Users profile]
  Future<void> updateUserProfile({
    String name,
    String photo,
    String email,
  }) async {
    await auth.currentUser.updateProfile(displayName: name, photoURL: photo);
    try {
      await auth.currentUser.updateEmail(email);
    } catch (e) {
      Get.rawSnackbar(
          title: 'Error', message: '$e', duration: Duration(seconds: 5));
    }
    await updateDB();
  }

  /// [Sign Out a User]
  Future<void> logout() async => await auth.signOut();
}
