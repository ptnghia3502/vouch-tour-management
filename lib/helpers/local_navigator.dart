import 'dart:html';
import 'package:admin/routing/route_names.dart';
import 'package:admin/routing/router.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

Navigator localNavigator() =>   Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: dashboardPageRoute,
    );