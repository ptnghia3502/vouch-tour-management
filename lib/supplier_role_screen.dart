import 'package:admin/screens/main/main_screen_supplier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/MenuAppController.dart';
class SupplierRoleScreen extends StatelessWidget {
   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: MainScreenSupplier(),
      ),
    );
  }
}