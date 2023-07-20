import 'package:admin/helpers/local_navigator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import '../../Authentication/sharedPreferencesManager.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/product_supplier_controller.dart';
import '../../controllers/supplier_controller.dart';
import '../../controllers/tourguide_controller.dart';
import '../../models/global.dart';
import '../../routing/route_names.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// The scopes required by this application.
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class UserController extends GetxController {
  var user = Rx<User?>(null);
  final SharedPreferencesManager prefs = SharedPreferencesManager();

  GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    clientId:
        '248437325496-4hrpv66dimdkj809fmtjl5vg2ekfac7e.apps.googleusercontent.com',
    scopes: scopes,
  );
  Future<void> googleSignIn1(BuildContext context) async {
    try {
      // GoogleSignIn googleSignIn = GoogleSignIn(
      //   // Optional clientId
      //   clientId:
      //       '248437325496-4hrpv66dimdkj809fmtjl5vg2ekfac7e.apps.googleusercontent.com',
      //   scopes: scopes,
      // );
      GoogleSignInAccount? googleUser = kIsWeb
          ? await (googleSignIn.signInSilently())
          : await (googleSignIn.signIn());

      if (kIsWeb && googleUser == null)
        googleUser = await (googleSignIn.signIn());
      // final GoogleSignInAccount? googleUser = await GoogleSignIn(
      //   // Optional clientId
      //   clientId:
      //       '248437325496-4hrpv66dimdkj809fmtjl5vg2ekfac7e.apps.googleusercontent.com',
      //   scopes: scopes,
      // ).signIn();
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
            Get.delete<SupplierController>();
            Get.put(SupplierController());
            Get.delete<TourGuideController>();
            Get.put(TourGuideController());
            Get.delete<CategoryController>();
            Get.put(CategoryController());
            Get.delete<ProductController>();
            Get.put(ProductController());
          } else if (role == 'Supplier') {
            // Navigator.pushReplacement(
            //     context,
            //     new MaterialPageRoute(
            //         builder: (context) => new SupplierRoleScreen()));
            Get.offNamed(supplierRolePageRoute);
            Get.delete<ProductSupplierController>();
            Get.put(ProductSupplierController());
            Get.delete<CategoryController>();
            Get.put(CategoryController());
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
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    await prefs.logout1();
    await SharedPreferencesManager.logout();
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
                userController.googleSignIn1(context);
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
