import 'package:demotask/core/utils/app_functions.dart';
import 'package:demotask/ui/home_screen/home_screen.dart';
import 'package:demotask/ui/shared/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationPhone {
  static signInWithPhoneCredential(
      {required String smsCode, required String enteredCode}) async {
    try {
      LoadingOverlay.of().show();
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: enteredCode, smsCode: smsCode))
          .then((value) {
        Get.offAllNamed(HomeScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        flutterToast('InvalidCode');
        LoadingOverlay.of().hide();
      } else {
        flutterToast(e.message ?? 'ErrorPhoneAuthMsg');
        LoadingOverlay.of().hide();
      }
    } catch (e) {
      flutterToast(e.toString());
      LoadingOverlay.of().hide();
    }
  }

  static verifyPhoneNumber(
      {required Function(String verificationId, int? resendToken) onCodeSent,
      required Function(PhoneAuthCredential) onVerificationCompleted,
      required Function(FirebaseAuthException) onVerificationFailed,
      required Function(String) onCodeAutoRetrievalTimeout,
      required String number,
      required String dialCode}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: dialCode + number,
          timeout: const Duration(seconds: 60),
          verificationCompleted: onVerificationCompleted,
          verificationFailed: onVerificationFailed,
          codeSent: onCodeSent,
          codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout);
    } on FirebaseAuthException catch (e) {
      flutterToast(e.message ?? 'ErrorPhoneAuthMsg');
    } catch (e) {
      flutterToast(e.toString());
    }
  }
}
