import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final lc = LoginController.to;
  InputDecoration decor(String label, String hint) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(37), gapPadding: 1),
      labelText: label,
      hintText: hint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Form(
              key: lc.formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 190,
                      ),
                    )),
                    TextButton.icon(
                        label: Text(
                          'Sign in with Google',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        icon: Icon(
                          FlutterIcons.google_ant,
                          color: Colors.green,
                        ),
                        onPressed: lc.authService.signInWithGoogle),
                    SizedBox(height: 10),
                    Center(child: Text('OR')),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildSelector(
                            Selection.email, 'Email', FlutterIcons.email_mco),
                        buildSelector(
                            Selection.phone, 'Phone', FlutterIcons.phone_mco)
                      ],
                    ),
                    SizedBox(height: 20),
                    if (lc.selection.value == Selection.email) ...[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: lc.emailValidator,
                          controller: lc.emailController,
                          decoration: decor('Email', 'Enter your email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: lc.passValidator,
                          controller: lc.passController,
                          obscureText: true,
                          decoration: decor('Password', 'Enter your password'),
                        ),
                      ),
                      lc.submitting.value
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: MaterialButton(
                                padding: EdgeInsets.all(18),
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: lc.signIn,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: MaterialButton(
                            padding: EdgeInsets.all(18),
                            color: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Get.toNamed('/registration');
                            }),
                      ),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator: lc.emailValidator,
                          controller: lc.phoneController,
                          decoration: decor('Phone Number',
                              'Enter your registered Phone number'),
                        ),
                      ),
                      lc.otpSent.value
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                validator: lc.passValidator,
                                controller: lc.otpController,
                                decoration: decor('OTP', 'Enter OTP'),
                              ),
                            )
                          : Container(),
                      lc.submitting.value
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: MaterialButton(
                                padding: EdgeInsets.all(18),
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  !lc.otpSent.value ? 'Send OTP' : 'Check OTP',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed:
                                    lc.otpSent.value ? lc.checkOtp : lc.sendOtp,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: MaterialButton(
                            padding: EdgeInsets.all(18),
                            color: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => Get.toNamed('/registration')),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildSelector(Selection selection, String title, IconData icon) {
    return GestureDetector(
      onTap: () => lc.selection.value = selection,
      child: Container(
        margin: EdgeInsets.all(8),
        width: Get.width * 0.35,
        height: 40,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon,
                  color: selection == lc.selection.value ? Colors.white : null),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        selection == lc.selection.value ? Colors.white : null),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color:
              selection == lc.selection.value ? Colors.green : Colors.black12,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
