import 'package:admin/controllers/category_controller.dart';
import 'package:admin/controllers/product_controller.dart';
import 'package:admin/controllers/supplier_controller.dart';
import 'package:admin/controllers/supplier_report_controller.dart';
import 'package:admin/controllers/tourguide_controller.dart';
import 'package:flutter/material.dart';

import 'controllers/navigation_controller.dart';
import 'controllers/product_supplier_controller.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

NavigationController navigationController = NavigationController.instance;
SupplierController supplierController = SupplierController.instance;
TourGuideController tourGuideController = TourGuideController.instance;
CategoryController categoryController = CategoryController.instance;
ProductController productController = ProductController.instance;
ProductSupplierController productsupplierController = ProductSupplierController.instance;
SupplierReportController supplierreportController = SupplierReportController.instance;