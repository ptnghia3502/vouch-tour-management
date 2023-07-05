import 'package:admin/admin_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/supplier_role_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Authentication/sharedPreferencesManager.dart';
import '../../models/global.dart';
import '../../routing/route_names.dart';

/// The scopes required by this application.
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class UserController extends GetxController {
  var user = Rx<User?>(null);

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        // Optional clientId
        clientId:
            '248437325496-4hrpv66dimdkj809fmtjl5vg2ekfac7e.apps.googleusercontent.com',
        scopes: scopes,
      ).signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final idToken = googleAuth.idToken;
        final serverAuthCode = googleUser.serverAuthCode;
        final emailCurrentUser = googleUser.email;

        final url = Uri.parse('${BASE_URL}authentication');
        final headers = {'Content-Type': 'application/json'};
        final data = {'eMail': emailCurrentUser};
        final response =
            await http.post(url, headers: headers, body: jsonEncode(data));
        if (response.statusCode == 200) {
          //Get.toNamed('/dashboard');

          final body = json.decode(response.body);
          final accessToken = body['accessToken'];
          final id = body['id'];
          final role = body['role'];
          final refreshToken = body['refreshToken'];
          // Save the token to local storage
          //SharedPreferences prefs = await SharedPreferences.getInstance();
          SharedPreferencesManager prefs = SharedPreferencesManager();
          await prefs.setString('access_token', accessToken);
          await prefs.setString('refreshToken', refreshToken);
          await prefs.setString('role', role);
          await prefs.setString('id', id);
          await prefs.setString('emailCurrent', emailCurrentUser);

          print('Successful signing in with Google');
          if (role == 'Admin') {
            // Navigator.push(context,
            //     new MaterialPageRoute(builder: (context) => new AdminScreen()));
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => AdminScreen()),
            // );
            Get.offNamed(adminPageRoute);
          } else if (role == 'Suppiler') {
            // Navigator.pushReplacement(
            //     context,
            //     new MaterialPageRoute(
            //         builder: (context) => new SupplierRoleScreen()));
            Get.offNamed(supplierRolePageRoute);
          }
        } else {
          throw Exception('Failed to sign in with Google 1');
        }
      } else {
        throw Exception('Failed to sign in with Google 2');
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      throw Exception('Failed to sign in with Google 3');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? _user) {
      user.value = _user;
    });
  }
}

class LoginPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                // Xử lý sự kiện khi nút được nhấn
                userController.googleSignIn(context);
                if (userController.user.value != null) {}
              },
              icon: Icon(Icons.login),
              label: Text("Sign in with Google"),
            ),
            Obx(() => userController.user.value == null
                ? Text("You are not signed in.")
                : Column(
                    children: [
                      Text(
                          "Welcome, ${userController.user.value!.displayName ?? ''}"),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () => userController.logout(),
                        child: Text("Logout"),
                      )
                    ],
                  )),
          ],
        ),
      ),
    );
  }
}
