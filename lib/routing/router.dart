import 'package:admin/routing/route_names.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/product/product_screen.dart';
import 'package:admin/screens/supplier/supplier_screen.dart';
import 'package:admin/screens/order/order_screen.dart';

import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings){
  switch (settings.name){
    case dashboardPageRoute:
      return _getPageRoute(DashboardScreen());
    case ordersPageRoute:
      return _getPageRoute(OrderScreen());
    case productsPageRoute:
      return _getPageRoute(ProductScreen());
    case suppliersPageRoute:
      return _getPageRoute(SupplierScreen());
    default:
  }
  return null;
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}