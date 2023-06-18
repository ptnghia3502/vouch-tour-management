import 'dart:convert';

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
    super.onInit();
    fetchCategory();
  }

//AUTHENTICATION API
   static Future<String> fetchJwtToken(String email) async {
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
    }
    else if (response.statusCode == 401) {
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

   void fetchCategory() async{
    String jwtToken = CategoryController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await CategoryController.fetchJwtToken(
          CategoryController.currentEmail); // Fetch the JWT token if it's empty
    }
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