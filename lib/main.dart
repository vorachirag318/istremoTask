import 'package:demotask/ui/auth/face_auth.dart';
import 'package:demotask/ui/home_screen/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';

import 'core/constant/app_themes.dart';
import 'core/local_db/moor_db.dart';
import 'core/utils/app_routes.dart';
import 'core/utils/bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.I.registerSingletonAsync(() => MoorDbClient.getInstance());
  await GetIt.I.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Task",
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      initialRoute: FaceAuth.routeName,
      getPages: routes,
      theme: AppTheme.defTheme,
    );
  }
}
