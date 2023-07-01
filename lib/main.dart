import 'package:admin/constants.dart';
import 'package:admin/screens/login/login_V5.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin/routing/fluro-route.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'controllers/MenuAppController.dart';
import 'controllers/navigation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA__MARXRUpXlzu4GTnvBAi7v5s0XPlXKQ",
      projectId: "fir-authendemo-644b6",
      messagingSenderId: "978745240815",
      appId: "1:978745240815:web:43d4cb2a41d1b3cfecff1a",

      // Các thông tin cấu hình khác
    ),
  );
  Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
          ],
          child: child,
        );
      },
      home: LoginPage(),
    );
  }
}
