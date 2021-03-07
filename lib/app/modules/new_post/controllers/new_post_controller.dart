import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_lens/app/models/post.dart';
import 'package:green_lens/app/services/auth.dart';
import 'package:green_lens/app/services/db.dart';
import 'package:image_picker/image_picker.dart';

final formKey = GlobalKey<FormState>();

class NewPostController extends GetxController {
  static final to = Get.find<NewPostController>();
  TextEditingController titleController;
  TextEditingController contentController;
  File image;
  RxBool submitting = false.obs;
  RxBool imageSelected = false.obs;
  RxBool imageUploaded = false.obs;
  RxString imageUrl = ''.obs;

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    if (gallery) {
      pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxHeight: 500, maxWidth: 500);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }
    if (pickedFile != null) {
      image = File(pickedFile.path); // Use if you only need a single picture
      imageSelected.value = true;
    } else {
      print('No image selected.');
    }
  }

  Future uploadImage() async {
    print('image Uploading');
    submitting.value = true;

    imageUrl.value =
        await DBService().uploadFile(image, AuthService().auth.currentUser.uid);
    submitting.value = false;
    imageUploaded.value = true;
    print(imageUrl.value);
  }

  Future<void> addPost() async {
    if (image != null && !imageUploaded.value) await uploadImage();
    final post = Post(
      id: '${AuthService().auth.currentUser.uid}@${DateTime.now().millisecondsSinceEpoch}',
      title: titleController.text,
      content: contentController.text,
      date: '${DateTime.now().millisecondsSinceEpoch}',
      imageUrl: imageUrl.value,
      profile: '${AuthService().auth.currentUser.photoURL}',
      uploader: '${AuthService().auth.currentUser.displayName}',
      likes: [],
      comments: [],
    );

    await DBService().upsert('posts/${post.id}', post.toJson());
    imageUrl.value = '';
    imageSelected.value = false;
    imageUploaded.value = false;
    image = null;
    titleController.clear();
    contentController.clear();
    Get.back();
  }

  Future<void> onSubmit() async {
    submitting.value = true;
    if (formKey.currentState.validate()) await addPost();
    submitting.value = false;
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    super.onInit();
  }
}
