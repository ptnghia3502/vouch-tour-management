import 'dart:html';
import 'package:admin/routing/route_names.dart';
import 'package:admin/routing/router.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

Navigator localNavigator(String route) => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: route,
    );

