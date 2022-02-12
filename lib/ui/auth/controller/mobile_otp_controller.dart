import 'package:demotask/core/service/firebase_service.dart';
import 'package:demotask/core/utils/app_functions.dart';
import 'package:demotask/ui/home_screen/home_screen.dart';
import 'package:demotask/ui/shared/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileOtpController extends GetxController {
  bool _isOtpFiledShown = false;

  bool get isOtpFiledShown => _isOtpFiledShown;

  set isOtpFiledShown(bool value) {
    _isOtpFiledShown = value;
    update();
  }

  final TextEditingController mobileNumberTextController =
      TextEditingController();
  final TextEditingController otpTextController = TextEditingController();
  String? verifyId;
  validateForm() async {
    LoadingOverlay.of().show();

    await AuthenticationPhone.verifyPhoneNumber(
      dialCode: "+91",
      number: mobileNumberTextController.text.trim(),
      onVerificationCompleted: (PhoneAuthCredential credential) {},
      onVerificationFailed: (FirebaseAuthException e) {
        flutterToast(e.message!);
      },
      onCodeAutoRetrievalTimeout: (String verificationId) {},
      onCodeSent: (String verificationId, int? resendToken) {
        verifyId = verificationId;
        disposeKeyboard();
        LoadingOverlay.of().hide();
        flutterToast("OTP sent");
        isOtpFiledShown = true;
      },
    );
  }

  Future<void> codeVerify() async {
    if (verifyId != null) {
      AuthenticationPhone.signInWithPhoneCredential(
          smsCode: otpTextController.text.trim(), enteredCode: verifyId!);
    }
  }
}
