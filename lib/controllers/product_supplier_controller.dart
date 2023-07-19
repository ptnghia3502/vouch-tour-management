import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:admin/models/global.dart';
import 'package:admin/models/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../Authentication/sharedPreferencesManager.dart';
import '../models/category_model.dart';

class ProductSupplierController extends GetxController {
  static ProductSupplierController instance = Get.find();

  //searching
  var productSupplierList = <Product>[].obs;
  var foundProductList = <Product>[].obs;

  //paging
  var currentPage = 1.obs;
  final itemsPerPage = 10;

  static String? jwtToken = '';
  static String? supplierId = '';

  //sorting
  var isAscending = true.obs;
  var sortColumnIndex = 0.obs;

  //upload image
  List<int>? selectedFile;
  Uint8List? bytesData;
  String? filename;

  //
  Product? productModel;
  Category? categoryModel;
  //textEditingController
  TextEditingController productIdTextController = TextEditingController();
  TextEditingController productNameTextController = TextEditingController();
  TextEditingController productResellTextController = TextEditingController();
  TextEditingController productRetailTextController = TextEditingController();
  TextEditingController productDescriptionTextController =
      TextEditingController();
  TextEditingController productStatusTextController = TextEditingController();
  TextEditingController productStatusCreateTextController = TextEditingController();
  TextEditingController productSupplierTextController = TextEditingController();
  TextEditingController productCategoryTextController = TextEditingController();
  String productCategory = 'Bánh Kẹo';

//get user login
  SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager();
  @override
  Future<void> onInit() async {
    if (sharedPreferencesManager.getString('access_token') != null) {
      super.onInit();
      fetchProductBySupplierId();
      productStatusCreateTextController.text = 'Hoạt động';
    } else {
      // Get.offNamed(loginPageRoute);
    }
  }

  //==================get all products============
  void fetchProductBySupplierId() async {
    jwtToken = sharedPreferencesManager.getString('access_token');
    supplierId = sharedPreferencesManager.getString('id');
    http.Response response = await http.get(
        Uri.parse('${BASE_URL}suppliers/$supplierId/products'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      final List<dynamic> productJson = jsonDecode(response.body);
      productSupplierList.value =
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

    return productSupplierList.length >= endIndex
        ? foundProductList.sublist(startIndex, endIndex)
        : foundProductList.sublist(startIndex);
  }

  void nextPage() {
    if (currentPage.value * itemsPerPage < productSupplierList.length) {
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
      results = productSupplierList;
    } else {
      results = productSupplierList
          .where((element) => element.productName
              .toString()
              .toLowerCase()
              .contains(productName.toLowerCase()))
          .toList();
    }
    productSupplierList.value = results as List<Product>;
  }

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
    bytesData = null;
    selectedFile = null;
  }

//==================insert product==============
  Future<bool> insertProduct() async {
    try {
      //get jwtToken
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
        'ResellPrice' : productResellTextController.text,
        'RetailPrice' : productRetailTextController.text,
        'Description' : productDescriptionTextController.text,
        'Status' : productStatusCreateTextController.text == 'Hoạt động' ? 'Active' : '',
        'CategoryId' : productCategory,
      });
      //send the request
      var response = await request.send();

      //check the response status
      if (response.statusCode == 201) {
        fetchProductBySupplierId();
        clearTextController();
        print('True 201');
        return true;
      }
      print('False');
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
        print('Post success');
        fetchProductBySupplierId();
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

  //==============update Product=============
  Future<bool> updateProduct(String id) async {
    try {
      jwtToken = sharedPreferencesManager.getString('access_token');
      //multipart request
      var request =
          http.MultipartRequest('PUT', Uri.parse('${BASE_URL}products'));
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
      request.fields.addAll({
        'CategoryId': productCategoryTextController.text,
        'ProductName': productNameTextController.text,
        'ResellPrice': productResellTextController.text,
        'RetailPrice': productRetailTextController.text,
        'Description': productDescriptionTextController.text,
        'Status': productStatusTextController.text,
        'ProductId': id
      });

      //send request
      var response = await request.send();

      //check statusCode
      if (response.statusCode == 204) {
        fetchProductBySupplierId();
        return true;
      }
      return false;
    } catch (e) {}
    return false;
  }
}
