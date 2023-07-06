import 'dart:convert';
import 'dart:typed_data';

import 'package:admin/models/global.dart';
import 'package:admin/models/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Authentication/sharedPreferencesManager.dart';
import '../routing/route_names.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  Product? productModel;

  //searching
  var productList = <Product>[].obs;
  var foundProductList = <Product>[].obs;

  //paging
  var currentPage = 1.obs;
  final itemsPerPage = 5;

  String? jwtToken = '';
  //static String currentEmail = 'hieuvh0804@gmail.com';

  //sorting
  var isAscending = true.obs;
  var sortColumnIndex = 0.obs;

  //upload image
  List<int>? selectedFile;
  Uint8List? bytesData;
  String? filename;

  //textEditingController
  TextEditingController productNameTextController = TextEditingController();
  //clear textcontroller
  Future<void> clearTextController() async {
    productNameTextController.clear();
  }

  //get user login
  SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager();
  @override
  Future<void> onInit() async {
    if (sharedPreferencesManager.getString('access_token') != null) {
      super.onInit();
      fetchProduct();
    } else {
      Get.offNamed(loginPageRoute);
    }
  }

  //==================get all products============
  void fetchProduct() async {
    jwtToken = sharedPreferencesManager.getString('access_token');
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
    foundProductList.sort((a, b) {
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
      foundProductList = foundProductList.reversed.toList().obs;
    }
  }

  //=================paging==============
  List<Product> get paginatedProduct {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    return productList.length >= endIndex
        ? foundProductList.sublist(startIndex, endIndex)
        : foundProductList.sublist(startIndex);
  }

  void nextPage() {
    if (currentPage.value * itemsPerPage < productList.length) {
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

//==================insert Product==============
  Future<bool> insertProduct() async {
    try {
      jwtToken = sharedPreferencesManager.getString('access_token');
      //MultiPart request
      var request =
          http.MultipartRequest('POST', Uri.parse('${BASE_URL}products'));
      Map<String, String> headers = {
        'Authorization': 'Bearer $jwtToken',
        'Content-type': 'multipart/form-data'
      };
      //thêm file cho request
      request.files.add(await http.MultipartFile.fromBytes(
          'File', selectedFile!,
          filename: filename, contentType: MediaType('image', 'png')));
      //thêm hearders
      request.headers.addAll(headers);
      //thêm field cho request
      request.fields.addAll({
        'ProductName': productNameTextController.text,
      });
      //send the request
      var response = await request.send();

      //check the response status
      if (response.statusCode == 201) {
        fetchProduct();
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
    return false;
  }

  //===============delete product===========
  Future<bool> deleteProduct(String id) async {
    try {
      jwtToken = sharedPreferencesManager.getString('access_token');
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      };
      var url = Uri.parse('${BASE_URL}products/$id');
      http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        print('Delete Product Success');
        fetchProduct();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  //==============get product by id================
  Future<void> getProductById(String id) async {
    jwtToken = sharedPreferencesManager.getString('access_token');
    http.Response response = await http.get(
        Uri.parse('${BASE_URL}products/$id'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      var result = jsonDecode(response.body);
      productModel = Product.fromJson(result);
      productNameTextController.text = result['ProductName'];
      http.Response urlReponse = await http.get(Uri.parse(categoryModel!.url));
      bytesData = urlReponse.bodyBytes;
    } else {
      throw Exception('Failed to fetch suppliers');
    }
  }

  //==============update Category=============
  Future<bool> updateCategory(String id) async {
    try {
      jwtToken = sharedPreferencesManager.getString('access_token');
      //multipart request
      var request =
          http.MultipartRequest('PUT', Uri.parse('${BASE_URL}categories'));
      Map<String, String> headers = {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'multipart/form-data'
      };
      //them file
      request.files.add(await http.MultipartFile.fromBytes(
          'File', selectedFile!,
          filename: filename, contentType: MediaType('image', 'png')));
      //add header
      request.headers.addAll(headers);
      //add field
      request.fields
          .addAll({'ProductName': productNameTextController.text, 'Id': id});

      //send request
      var response = await request.send();

      //check statusCode
      if (response.statusCode == 204) {
        fetchProduct();
        return true;
      }
      return false;
    } catch (e) {}
    return false;
  }
}
