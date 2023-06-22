import 'dart:convert';

import 'package:admin/models/global.dart';
import 'package:admin/models/product_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../screens/login/auth_provider.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  static String jwtToken = '';
  static String currentEmail = 'hieuvh0804@gmail.com';

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchProduct();
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
    } else if (response.statusCode == 401) {
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

  void fetchProduct() async {
    String jwtToken = ProductController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await ProductController.fetchJwtToken(
          ProductController.currentEmail); // Fetch the JWT token if it's empty
    }
    http.Response response = await http.get(Uri.parse('${BASE_URL}products'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      final List<dynamic> productJson = jsonDecode(response.body);
      productList.value =
          productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  Future<Product> findProductById(String Id) async {
    final url = Uri.parse('${BASE_URL}products/$Id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Product.fromJson(jsonData);
    } else {
      throw Exception('Failed to find category by ID');
    }
  }

  Future<Product> UpdateProduct(String Id) async {
    final url = Uri.parse('${BASE_URL}products/$Id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Product.fromJson(jsonData);
    } else {
      throw Exception('Failed to find category by ID');
    }
  }

  Future<bool> DeleteProduct(String Id) async {
    final url = Uri.parse('${BASE_URL}products/$Id');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      fetchProduct();

      return true;
    } else {
      //throw Exception('Failed to delete product by ID');
      return false;
    }
  }
}
