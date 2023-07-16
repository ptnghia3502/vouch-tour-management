import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/helpers/local_navigator.dart';
import 'package:admin/responsive.dart';
import 'package:admin/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu_supplier.dart';

class MainScreenSupplier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenuSupplier(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenuSupplier(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: localNavigator(productssupplierPageRoute)
            ),
          ],
        ),
      ),
    );
  }
}
