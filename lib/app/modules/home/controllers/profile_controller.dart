import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/auth.dart';
import '../../../services/db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils.dart';

class ProfileController extends GetxController {
  static final to = Get.find<ProfileController>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File image;
  RxBool editing = false.obs;
  RxString imageUrl = ''.obs;
  RxBool otpSent = false.obs;
  RxBool otpValid = false.obs;
  RxBool imageUploaded = false.obs;
  RxBool submitting = false.obs;
  RxBool imageSelected = false.obs;
  final authService = AuthService();
  Rx<User> currentUser = FirebaseAuth.instance.currentUser.obs;

  final emailValidator =
      (String s) => GetUtils.isEmail(s) ? null : 'Enter a valid email!';
  final passValidator =
      (String s) => s.length >= 6 ? null : 'Enter at least 6 characters!';
  final phoneValidator = (String s) =>
      GetUtils.isPhoneNumber(s) ? null : 'Enter a valid phone number';
  Future logout() async {
    await authService.logout();
    Get.offNamed('/login');
  }

  onEditTap() {
    image = null;
    imageUploaded.value = false;
    editing.value = true;
  }

  changeLanguage() {}

  changeTheme() {
    Get.changeTheme(
        Get.theme.brightness == Brightness.light ? darkTheme : lightTheme);
    Timer(Duration(milliseconds: 500), () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
          'theme', Get.theme.brightness == Brightness.light ? 'light' : 'dark');
    });
  }

  Future uploadImage() async {
    submitting.value = true;

    imageUrl.value =
        await DBService().uploadFile(image, authService.auth.currentUser.uid);
    submitting.value = false;
    imageUploaded.value = true;
    print(imageUrl.value);
  }

  Future<void> onSubmit() async {
    print('on submit');
    if (formKey.currentState.validate()) {
      await updateProfile();
      editing.value = false;
    }
  }

  Future sendOtp() async {
    if (GetUtils.isPhoneNumber(phoneController.text)) {
      submitting.value = true;

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
    Get.defaultDialog(
        title: 'Enter OTP',
        content: Column(
          children: [
            TextField(controller: otpController),
            TextButton(
                onPressed: () async {
                  if (GetUtils.isNumericOnly(otpController.text)) {
                    await authService.updatePhoneNumber(otpController.text);

                    Get.back();
                    editing.value = false;

                    Get.rawSnackbar(
                        title: 'Success',
                        message: "OTP is valid, updating number");
                  } else {
                    Get.rawSnackbar(
                        title: 'Warning', message: "Enter 6 digit OTP");
                  }
                },
                child: Text('Submit')),
          ],
        ));
  }

  Future<void> updateProfile() async {
    print('updating profile');
    await authService.updateUserProfile(
        name: nameController.text,
        email: emailController.text,
        photo: imageUrl.value ??
            'https://developers.google.com/web/images/contributors/no-photo.jpg');
    imageUrl.value = '';
    imageSelected.value = false;
  }

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }
    if (pickedFile != null) {
      image = File(pickedFile.path); // Use if you only need a single picture
      imageSelected.value = true;
    } else {
      print('No image selected.');
    }
  }

  @override
  void onReady() {
    authService.currentUser.listen((user) => currentUser.value = user);
    nameController.text = currentUser.value.displayName;
    phoneController.text = currentUser.value.phoneNumber;
    emailController.text = currentUser.value.email;
    imageUrl.value = authService.auth?.currentUser?.photoURL ??
        'https://developers.google.com/web/images/contributors/no-photo.jpg';
    super.onReady();
  }
}
