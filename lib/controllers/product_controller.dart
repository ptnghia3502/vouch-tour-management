import 'dart:convert';
import 'dart:typed_data';

import 'package:admin/constants.dart';
import 'package:admin/models/category_model.dart';
import 'package:admin/models/global.dart';
import 'package:admin/models/product_model.dart';
import 'package:admin/models/supplier_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Authentication/sharedPreferencesManager.dart';
import '../routing/route_names.dart';
import 'package:flutter/widgets.dart';
import 'package:http_parser/http_parser.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  Product? productModel;
  Category? categoryModel;

  //searching
  var productList = <Product>[].obs;
  var foundProductList = <Product>[].obs;

  //paging
  var currentPage = 1.obs;
  final itemsPerPage = 10;

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
  TextEditingController productIdTextController = TextEditingController();
  TextEditingController productNameTextController = TextEditingController();
  TextEditingController productResellTextController = TextEditingController();
  TextEditingController productRetailTextController = TextEditingController();
  TextEditingController productDescriptionTextController =
      TextEditingController();
  TextEditingController productStatusTextController = TextEditingController();
  TextEditingController productSupplierTextController = TextEditingController();
  TextEditingController productCategoryTextController = TextEditingController();

  //clear textcontroller
  Future<void> clearTextController() async {
    productIdTextController.clear();
    productNameTextController.clear();
    productResellTextController.clear();
    productRetailTextController.clear();
    productDescriptionTextController.clear();
    productStatusTextController.clear();
    productSupplierTextController.clear();
    productCategoryTextController.clear();
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
        return a.productName.compareTo(b.productName);
      } else if (columnIndex == 2) {
        return a.resellPrice.compareTo(b.resellPrice);
      } else if (columnIndex == 3) {
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
      productIdTextController.text = productModel!.id;
      productNameTextController.text = productModel!.productName;
      productResellTextController.text = productModel!.resellPrice.toString();
      productRetailTextController.text = productModel!.retailPrice.toString();
      productDescriptionTextController.text = productModel!.description;
      productStatusTextController.text = productModel!.status == 'Active' ? 'Hoạt động' : 'Ngưng hoạt động';
      productCategoryTextController.text = productModel!.category.id;
      productSupplierTextController.text = productModel!.supplier.id;
    } else {
      throw Exception('Failed to fetch product');
    }
  }
}
