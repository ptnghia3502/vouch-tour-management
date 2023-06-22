import 'dart:convert';

import 'package:admin/models/global.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/supplier_model.dart';
class SupplierController extends GetxController{
  static SupplierController instance = Get.find();
  TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
  var currentPage = 0.obs;
  final itemsPerPage = 10;
  var supplierList = <Supplier>[].obs;
  var foundsupplierList = <Supplier>[].obs;
  static String jwtToken = '';
  static String currentEmail = 'hieuvh0804@gmail.com';

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchSupplier();
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

  //fetch api
   void fetchSupplier() async{
    String jwtToken = SupplierController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await SupplierController.fetchJwtToken(
          SupplierController.currentEmail); // Fetch the JWT token if it's empty
    }
      http.Response response = await http.get(Uri.parse(
        '${BASE_URL}suppliers'),
        headers: {
          'Authorization': 'Bearer $jwtToken'
        }
        );
      if(response.statusCode == 200){
        //data successfully
        final List<dynamic> supplierJson = jsonDecode(response.body);
        supplierList.value = supplierJson.map((json) => Supplier.fromJson(json)).toList();
        foundsupplierList.value = supplierJson.map((json) => Supplier.fromJson(json)).toList();        
    }
    else{
      throw Exception('Failed to fetch suppliers');
    }
  }
  // this method is searching
    void filterSupplier(String supplierName){
    var results = [];
    if(supplierName.isEmpty){
      results = supplierList;
    }
    else{
      results = supplierList.where((element) => element.supplierName.toString().toLowerCase().contains(supplierName.toLowerCase())).toList();
    }
    foundsupplierList.value = results as List<Supplier>;
  }

  //this method is paging
    List<Supplier> get currentItems{
      final startIndex = currentPage.value * itemsPerPage;
      final endIndex = (startIndex + itemsPerPage).clamp(0, supplierList.length);
      return foundsupplierList.sublist(startIndex, endIndex);
    }

    void nextPage(){
      if(currentPage.value < (foundsupplierList.length / itemsPerPage).ceil() - 1){
        currentPage.value++;
      }
    }

    void previousPage(){
      if(currentPage.value > 0){
        currentPage.value--;
      }
    }
}
