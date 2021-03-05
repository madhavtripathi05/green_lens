import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  static final to = Get.find<RegistrationController>();
  RxBool otpSent = false.obs;
  RxBool otpValid = false.obs;
  final authService = AuthService();
  SharedPreferences prefs;
  final formKey = GlobalKey<FormState>();
  final phoneValidator = (String s) =>
      GetUtils.isPhoneNumber(s) ? null : "Enter a valid phone number";
  final emailValidator =
      (String s) => GetUtils.isEmail(s) ? null : 'Enter a valid email!';
  final passValidator =
      (String s) => s.length >= 6 ? null : 'Enter at least 6 characters!';
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final otpController = TextEditingController();
  final passController = TextEditingController();
  AuthCredential phoneCredential;
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
      var user = await authService.signInWithOtp(otpController.text);
      otpValid.value = user.uid != null;
    } else {
      Get.rawSnackbar(title: 'Warning', message: "Enter 6 digit OTP");
    }
  }

  Future<void> register() async {
    if (formKey.currentState.validate()) {
      submitting.value = true;
      await authService.registerUser(
          name: nameController.text,
          email: emailController.text,
          password: passController.text);
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
    nameController.text = prefs.getString('name');
    authService.currentUser.listen((user) {
      if (user.phoneNumber != null && user.email != null) {
        log('${user.email} ${user.phoneNumber} logged in');
        if (Get.currentRoute != '/home') {
          Get.offNamed('/home');
        }
      } else
        log('No one is logged in!');
    });
    super.onReady();
  }

  @override
  void onClose() {
    // nameController?.dispose();
    // emailController?.dispose();
    // phoneController?.dispose();
    super.onClose();
  }
}
