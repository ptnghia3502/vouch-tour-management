import 'package:admin/admin_screen.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/category_controller.dart';
import 'package:admin/controllers/navigation_controller.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/controllers/product_supplier_controller.dart';
import 'package:admin/controllers/supplier_controller.dart';
import 'package:admin/controllers/tourguide_controller.dart';
import 'package:admin/routing/route_names.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/supplier_role_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Get.put(SupplierController());
  Get.put(TourGuideController());
  Get.put(CategoryController());
  Get.put(ProductController());
  Get.put(ProductSupplierController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: loginPageRoute,
      getPages: [
        GetPage(
            name: rootRoute,
            page: () {
              return LoginPage();
            }),
        GetPage(name: supplierRolePageRoute, page: () => SupplierRoleScreen()),
        GetPage(name: adminPageRoute, page: () => AdminScreen()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
    );
  }
}
