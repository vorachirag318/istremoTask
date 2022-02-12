import 'package:demotask/ui/auth/face_auth.dart';
import 'package:demotask/ui/auth/login_otp_auth.dart';
import 'package:demotask/ui/home_screen/home_screen.dart';
import 'package:get/get.dart';

final List<GetPage<dynamic>> routes = [
  GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
  GetPage(name: FaceAuth.routeName, page: () => const FaceAuth()),
  GetPage(name: LoginOtpScreen.routeName, page: () => LoginOtpScreen()),
];
