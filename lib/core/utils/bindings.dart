import 'package:demotask/ui/auth/controller/mobile_otp_controller.dart';
import 'package:demotask/ui/home_screen/controller/home_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<MobileOtpController>(() => MobileOtpController(), fenix: true);
  }
}
