import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  InputDecoration decor(String label, String hint) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(37), gapPadding: 1),
      labelText: label,
      hintText: hint,
    );
  }

  final rc = RegistrationController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Obx(
        () => Form(
          key: rc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  validator: rc.passValidator,
                  controller: rc.nameController,
                  decoration: decor(
                      'Full Name', 'Enter your Full Name e.g. Steve Jobs'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  validator: rc.phoneValidator,
                  controller: rc.phoneController,
                  decoration: decor('Phone Number',
                      'Enter your Phone no. eg. +91 99999 88888'),
                ),
              ),
              rc.otpSent.value
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        validator: rc.passValidator,
                        controller: rc.otpController,
                        decoration:
                            decor('OTP', 'Enter 6 Digit OTP e.g. 123321'),
                      ),
                    )
                  : Container(),
              rc.submitting.value
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : rc.otpValid.value
                      ? Center(
                          child: Text(
                            'OTP Valid!',
                            style: TextStyle(color: Colors.green),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: MaterialButton(
                            padding: EdgeInsets.all(18),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              !rc.otpSent.value ? 'Send OTP' : 'Check OTP',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed:
                                rc.otpSent.value ? rc.checkOtp : rc.sendOtp,
                          ),
                        ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  validator: rc.emailValidator,
                  controller: rc.emailController,
                  decoration: decor('Email', 'Enter your email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  validator: rc.passValidator,
                  controller: rc.passController,
                  obscureText: true,
                  decoration: decor('Password', 'Enter your password'),
                ),
              ),
              rc.submitting.value
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MaterialButton(
                        padding: EdgeInsets.all(18),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: rc.register,
                      ),
                    ),
            ],
          ),
        ),
      )),
    );
  }
}
