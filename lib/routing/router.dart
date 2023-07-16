import 'package:admin/routing/route_names.dart';
import 'package:admin/screens/category/category_screen.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/dashboard_supplier/dashboard_supplier_screen.dart';
import 'package:admin/screens/product/product_screen.dart';
import 'package:admin/screens/product_supplier/product_supplier_screen.dart';
import 'package:admin/screens/supplier/supplier_screen.dart';
import 'package:admin/screens/order/order_screen.dart';
import 'package:admin/screens/tourguide/tourguide_screen.dart';

import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardAdminPageRoute:
      return _getPageRoute(DashboardScreenAdmin());
    case dashboardSupPageRoute:
      return _getPageRoute(DashboardSupplierScreen());
    case ordersPageRoute:
      return _getPageRoute(OrderScreen());
    case productsPageRoute:
      return _getPageRoute(ProductScreen());
    case suppliersPageRoute:
      return _getPageRoute(SupplierScreen());
    case tourguidesPageRoute:
      return _getPageRoute(TourGuideScreen());
    case categoriesPageRoute:
      return _getPageRoute(CategoryScreen());
    case productssupplierPageRoute:
      return _getPageRoute(ProductSupplierScreen());
    default:
  }
  return null;
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
