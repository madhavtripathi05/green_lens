import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Selection { phone, email }

class LoginController extends GetxController {
  static final to = Get.find<LoginController>();
  Rx<Selection> selection = Selection.email.obs;
  RxBool otpSent = false.obs;
  final authService = AuthService();
  SharedPreferences prefs;
  final formKey = GlobalKey<FormState>();

  final emailValidator =
      (String s) => GetUtils.isEmail(s) ? null : 'Enter a valid email!';
  final passValidator =
      (String s) => s.length >= 6 ? null : 'Enter at least 6 characters!';
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final passController = TextEditingController();
  RxBool submitting = false.obs;

  Future sendOtp() async {
    if (GetUtils.isPhoneNumber(phoneController.text)) {
      submitting.value = true;
      prefs.setString('phone', phoneController.text);

      await authService.requestOtpUsingPhoneNumber(phoneController.text);

      submitting.value = false;
      otpSent.value = true;
      Get.rawSnackbar(
          title: 'OTP Sent!', message: 'Please enter OTP to continue');
    } else {
      Get.rawSnackbar(title: 'Warning!', message: 'Enter a valid Phone number');
    }
  }

  Future checkOtp() async {
    if (GetUtils.isNumericOnly(otpController.text)) {
      await authService.signInWithOtp(otpController.text);
    } else {
      Get.rawSnackbar(title: 'Warning', message: "Enter 6 digit OTP");
    }
  }

  Future<void> signIn() async {
    if (formKey.currentState.validate()) {
      prefs.setString('email', emailController.text);
      submitting.value = true;
      await authService.signInWithEmail(
          emailController.text, passController.text);
      submitting.value = false;
      // no need as we're already listening to useChanged stream
      // Get.offNamed('/home');
    }
  }

  @override
  void onReady() async {
    prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('email');
    phoneController.text = prefs.getString('phone');
    authService.currentUser.listen((user) {
      if (user != null) {
        log('UID: ${user.uid}, Email: ${user.email} logged in');
        if (Get.currentRoute != '/home') {
          Get.offNamed('/home');
        }
      } else
        log('No one is logged in!');
    });
    super.onReady();
  }

  @override
  void onClose() {}
}
