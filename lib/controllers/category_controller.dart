import 'dart:convert';

<<<<<<< HEAD
import 'package:admin/models/category_model.dart';
import 'package:admin/models/global.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/supplier_model.dart';

class CategoryController extends GetxController {
  var categoryList = <Category>[].obs;
  static String jwtToken = '';
  static String currentEmail = 'hieuvh0804@gmail.com';

  @override
  Future<void> onInit() async {
=======
import 'package:admin/models/global.dart';
import 'package:admin/models/category_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class CategoryController extends GetxController{
  var categoryList = <Category>[].obs;
  static String jwtToken = '';
  static String currentEmail = 'hieuvh0804@gmail.com';
  

  @override
  Future<void> onInit() async{
>>>>>>> 2653c50abee0287b9f461635db90d82dfde3db0f
    super.onInit();
    fetchCategory();
  }

//AUTHENTICATION API
<<<<<<< HEAD
  static Future<String> fetchJwtToken(String email) async {
=======
   static Future<String> fetchJwtToken(String email) async {
>>>>>>> 2653c50abee0287b9f461635db90d82dfde3db0f
    final url = Uri.parse('${BASE_URL}authentication');
    final body = jsonEncode({
      'eMail': currentEmail,
    });

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      jwtToken = data['accessToken'];
      return jwtToken;
<<<<<<< HEAD
    } else if (response.statusCode == 401) {
=======
    }
    else if (response.statusCode == 401) {
>>>>>>> 2653c50abee0287b9f461635db90d82dfde3db0f
      // Access token expired, try refreshing the token using the refresh token
      final refreshToken = json.decode(response.body)['refreshToken'];
      final refreshResponse = await http.post(
        Uri.parse('${BASE_URL}authentication/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      );

      if (refreshResponse.statusCode == 200) {
        final refreshData = json.decode(refreshResponse.body);
        jwtToken = refreshData['accessToken'];
        currentEmail = email;
        return jwtToken;
      } else {
        throw Exception('Failed to refresh JWT token');
      }
    } else {
      throw Exception('Failed to fetch JWT token');
    }
  }

<<<<<<< HEAD
  void fetchCategory() async {
=======
   void fetchCategory() async{
>>>>>>> 2653c50abee0287b9f461635db90d82dfde3db0f
    String jwtToken = CategoryController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await CategoryController.fetchJwtToken(
          CategoryController.currentEmail); // Fetch the JWT token if it's empty
    }
<<<<<<< HEAD
    http.Response response = await http.get(Uri.parse('${BASE_URL}categories'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      final List<dynamic> categoryJson = jsonDecode(response.body);
      categoryList.value =
          categoryJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch suppliers');
    }
  }

  Future<Category> findCategoryById(String Id) async {
    final url = Uri.parse('${BASE_URL}categories/$Id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Category.fromJson(jsonData);
    } else {
      throw Exception('Failed to find category by ID');
    }
  }
}
=======
      http.Response response = await http.get(Uri.parse(
        '${BASE_URL}categories'),
        headers: {
          'Authorization': 'Bearer $jwtToken'
        }
        );
      if(response.statusCode == 200){
        //data successfully
        final List<dynamic> categoryJson = jsonDecode(response.body);
        categoryList.value = categoryJson.map((json) => Category.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to fetch suppliers');
    }
  }
}
>>>>>>> 2653c50abee0287b9f461635db90d82dfde3db0f
