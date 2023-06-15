import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text('LoginPage')),
  //     body: Center(
  //         child: FloatingActionButton.extended(
  //       onPressed: () {
  //         GoogleSignIn().signIn();
  //       },
  //       icon: Image.asset(
  //         'assets/images/logo_google.png',
  //         width: 24,
  //         height: 24,
  //       ),
  //       label: Text('Login with Google'),
  //       backgroundColor: Colors.white,
  //       foregroundColor: Colors.black,
  //     )),
  //   );
  // }
  Future<User?> _signInWithGoogle(GoogleSignInAccount? googleUser) async {
    //final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    //final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  // Future<User?> _signInWithGoogle() async {
  //   final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ]);

  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) return null;

  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //     final userCredential = await _auth.signInWithCredential(credential);
  //     return userCredential.user;
  //   } catch (error) {
  //     print('Error signing in with Google: $error');
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LoginPage')),
      body: Center(
          child: FloatingActionButton.extended(
        onPressed: () async {
          /*final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          await Firebase.initializeApp();
          User? user = await _signInWithGoogle(googleUser);
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }*/
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          await Firebase.initializeApp();

          if (googleUser != null) {
            // Lấy mã token của user hiện tại
            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;
            final String idToken = googleAuth.idToken ?? '';
            ;

            // Gửi mã token cho backend
            /*http.Response response = await http.post(
              Uri.parse(
                  'https://localhost:5001/api/loginbygoogles'), // bỏ api backend zô
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{'token': idToken}),
            );*/

            final String firebaseToken =
                await FirebaseAuth.instance.currentUser!.getIdToken();
            final Map<String, String> body = {
              'token': firebaseToken,
            };

            http.Response response = await http.post(
              Uri.parse('https://localhost:5001/api/authenticatewithgoogle'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(body),
            );

            // Kiểm tra kết quả từ backend
            if (response.statusCode == 200) {
              //Navigator.pushReplacementNamed(context, '/home');
              Fluttertoast.showToast(
                  msg: "Login  Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 10,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              //backend gửi lỗi
              Fluttertoast.showToast(
                  msg: "Login  Failed",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 10,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        icon: Image.asset(
          'assets/images/logo_google.png',
          width: 24,
          height: 24,
        ),
        label: Text('Login with Google'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      )),
    );
  }
}
