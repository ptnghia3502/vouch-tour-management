import 'package:admin/admin_screen.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/category_controller.dart';
import 'package:admin/controllers/navigation_controller.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/controllers/supplier_controller.dart';
import 'package:admin/controllers/tourguide_controller.dart';
import 'package:admin/routing/route_names.dart';
import 'package:admin/supplier_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Get.put(NavigationController());
  Get.put(SupplierController());
  Get.put(TourGuideController());
  Get.put(CategoryController());
  Get.put(ProductController());  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: adminPageRoute,
        getPages: [
        GetPage(name: rootRoute, page: () {
          return AdminScreen();
        }),
        GetPage(name: supplierRolePageRoute, page: () => SupplierRoleScreen()),
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
