import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfile extends StatelessWidget {
  final pc = ProfileController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Profile'),
            actions: [
              IconButton(
                  icon: Icon(pc.editing.value ? Icons.check : Icons.edit),
                  onPressed: !pc.editing.value ? pc.onEditTap : pc.onSubmit)
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: pc.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: !pc.editing.value
                          ? [
                              CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  backgroundImage: CachedNetworkImageProvider(
                                    pc?.currentUser?.value?.photoURL ??
                                        'https://developers.google.com/web/images/contributors/no-photo.jpg',
                                  )),
                            ]
                          : [
                              pc.imageSelected.value
                                  ? Column(
                                      children: [
                                        ClipRRect(
                                          child: Image.file(pc.image,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        pc.imageUploaded.value
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Image Uploaded!',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              )
                                            : pc.submitting.value
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        CircularProgressIndicator
                                                            .adaptive(),
                                                  )
                                                : TextButton(
                                                    onPressed: pc.uploadImage,
                                                    child: Text('upload'))
                                      ],
                                    )
                                  : RawMaterialButton(
                                      fillColor: Theme.of(context).accentColor,
                                      child: Icon(
                                        Icons.add_photo_alternate_rounded,
                                        color: Colors.white,
                                      ),
                                      elevation: 8,
                                      onPressed: () {
                                        pc.getImage(true);
                                      },
                                      padding: EdgeInsets.all(15),
                                      shape: CircleBorder(),
                                    )
                            ]),
                  ListTile(
                    leading: Icon(FlutterIcons.user_ant),
                    title: !pc.editing.value
                        ? Text(pc.currentUser.value.displayName ?? 'Unknown')
                        : TextFormField(
                            controller: pc.nameController,
                            validator: pc.passValidator,
                          ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('Full name'),
                    ),
                  ),
                  ListTile(
                    leading: Icon(FlutterIcons.email_mco),
                    title: !pc.editing.value
                        ? Text(pc.currentUser.value.email)
                        : TextFormField(
                            controller: pc.emailController,
                            validator: pc.emailValidator,
                          ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(pc.editing.value
                          ? 'Confirmation will be sent to your original email after that you will see updated email here'
                          : 'Email'),
                    ),
                  ),
                  ListTile(
                    leading: Icon(FlutterIcons.phone_mco),
                    title: !pc.editing.value
                        ? Text(pc.currentUser.value.phoneNumber ?? 'pending')
                        : TextFormField(
                            controller: pc.phoneController,
                            validator: pc.phoneValidator,
                          ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(pc.editing.value
                          ? 'OTP will be sent, Enter OTP to change Number'
                          : 'Phone Number'),
                    ),
                    trailing: pc.editing.value
                        ? TextButton(
                            onPressed:
                                pc.otpSent.value ? pc.checkOtp : pc.sendOtp,
                            child: Text(
                                pc.otpSent.value ? 'Check OTP' : 'Send OTP'))
                        : Text(''),
                  ),
                  !pc.editing.value
                      ? ListTile(
                          leading: Icon(FlutterIcons.dollar_faw),
                          title: Text('Order History'),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('View All of your previous orders'),
                          ),
                        )
                      : Text(''),
                  !pc.editing.value
                      ? ListTile(
                          leading: Icon(FlutterIcons.theme_light_dark_mco),
                          title: Text('Change Theme'),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Change theme for better visibility'),
                          ),
                          onTap: pc.changeTheme,
                        )
                      : Text(''),
                  !pc.editing.value
                      ? ListTile(
                          leading: Icon(FlutterIcons.language_ent),
                          title: Text('Change Language'),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Change App\'s default language'),
                          ),
                          onTap: pc.changeLanguage,
                        )
                      : Text(''),
                  !pc.editing.value
                      ? ListTile(
                          leading: Icon(FlutterIcons.exit_to_app_mdi),
                          title: Text('Sign Out'),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Sign Out of the app'),
                          ),
                          onTap: pc.logout,
                        )
                      : Text(''),
                ],
              ),
            ),
          ),
        ));
  }
}
