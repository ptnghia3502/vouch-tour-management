import 'dart:convert';

import 'package:admin/models/global.dart';
import 'package:admin/models/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ProductController extends GetxController {
  static ProductController instance = Get.find(); 

  //searching
  var productList = <Product>[].obs;
  var foundProductList = <Product>[].obs;

  //paging
  var currentPage = 1.obs;
  final itemsPerPage = 5;

  static String jwtToken = '';
  static String currentEmail = 'hieuvh0804@gmail.com';

  //sorting
  var isAscending = true.obs;
  var sortColumnIndex = 0.obs;

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

  //==================get all products============
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

      foundProductList.value =
          productJson.map((json) => Product.fromJson(json)).toList();          
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  //=================sorting=================================
  Future<void> sortList(int columnIndex) async {
    if (sortColumnIndex.value == columnIndex) {
      //Reverse the sort order if the same column is clicked again
      isAscending.value = !isAscending.value;
    } else {
      //sort the list in ascending order by default when a new column is clicked
      sortColumnIndex.value = columnIndex;
      isAscending.value = true;
    }
    productList.sort((a, b) {
      if (columnIndex == 1) {
        return a.id.compareTo(b.id);
      } else if (columnIndex == 2) {
        return a.productName.compareTo(b.productName);
      } else if (columnIndex == 3) {
        return a.resellPrice.compareTo(b.resellPrice);
      } else if (columnIndex == 4) {
        return a.retailPrice.compareTo(b.retailPrice);
      }
      return 0;
    });

    if (!isAscending.value) {
      productList = productList.reversed.toList().obs;
    }
  }

  //=================paging==============
  List<Product> get paginatedProduct{
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    return productList.length >= endIndex 
            ? foundProductList.sublist(startIndex, endIndex)
            : foundProductList.sublist(startIndex);
  }

  void nextPage() {
    if (currentPage.value * itemsPerPage < productList.length){
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

//==============searching===============
  void filterProduct(String productName) {
    var results = [];
    if (productName.isEmpty) {
      results = productList;
    } else {
      results = productList
          .where((element) => element.productName
              .toString()
              .toLowerCase()
              .contains(productName.toLowerCase()))
          .toList();
    }
    productList.value = results as List<Product>;
  }

}
