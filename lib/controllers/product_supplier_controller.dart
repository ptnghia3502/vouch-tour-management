import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:admin/models/global.dart';
import 'package:admin/models/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../models/category_model.dart';



class ProductSupplierController extends GetxController {
  static ProductSupplierController instance = Get.find(); 

  //searching
  var productSupplierList = <Product>[].obs;
  var foundProductList = <Product>[].obs;

  //paging
  var currentPage = 1.obs;
  final itemsPerPage = 5;

  static String jwtToken = '';
  static String supplierId = '';
  static String currentEmail = 'CauBeThoiTiet@gmail.com';

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
  TextEditingController productNameTextController = TextEditingController();
  TextEditingController productDesTextController = TextEditingController();
  TextEditingController productStatusTextController = TextEditingController();
  TextEditingController productCategoryTextController = TextEditingController();
  TextEditingController productResellPriceTextController = TextEditingController();
  TextEditingController productRetailPriceTextController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchProductBySupplierId();
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
      supplierId = data['id'];
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
  void fetchProductBySupplierId() async {
    String jwtToken = ProductSupplierController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await ProductSupplierController.fetchJwtToken(
          ProductSupplierController.currentEmail); // Fetch the JWT token if it's empty
    }
    http.Response response = await http.get(Uri.parse('${BASE_URL}suppliers/$supplierId/products'),
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
  List<Product> get paginatedProduct{
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    return productSupplierList.length >= endIndex 
            ? foundProductList.sublist(startIndex, endIndex)
            : foundProductList.sublist(startIndex);
  }

  void nextPage() {
    if (currentPage.value * itemsPerPage < productSupplierList.length){
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
  Future<void> clearTextController() async{
  productNameTextController.clear(); 
  productDesTextController.clear();  
  productStatusTextController.clear();  
  productCategoryTextController.clear();  
  productResellPriceTextController.clear();  
  productRetailPriceTextController.clear(); 
  bytesData = null;
  selectedFile = null; 
  }

//==================insert product==============
  Future<bool> insertProduct() async {
    try{
      //get jwtToken
      String jwtToken = ProductSupplierController.jwtToken;
      if (jwtToken.isEmpty) {
        jwtToken = await ProductSupplierController.fetchJwtToken(
            ProductSupplierController.currentEmail); // Fetch the JWT token if it's empty
      }      
      //MultiPart request
      var request = http.MultipartRequest(
        'POST', Uri.parse('${BASE_URL}products')
      );
      Map<String, String> headers = {
        'Authorization': 'Bearer $jwtToken',
        'Content-type' : 'multipart/form-data'
      };
      //thêm file cho request
      request.files.add( await
        http.MultipartFile.fromBytes(
          'File',
          selectedFile!,
          filename: filename,
          contentType: MediaType('image','png')
          )
      );
      //thêm hearders
      request.headers.addAll(headers);
      //thêm field cho request
      request.fields.addAll({
        'ProductName': productNameTextController.text,
        'ResellPrice' : productResellPriceTextController.text,
        'RetailPrice' : productRetailPriceTextController.text,
        'Description' : productDesTextController.text,
        'Status' : productStatusTextController.text,
        'CategoryId' : productCategoryTextController.text,
      });
      //send the request
      var response = await request.send();
      
      //check the response status
      if(response.statusCode == 201){
        fetchProductBySupplierId();
        clearTextController();
        return true;
      }
    return false;
    }
    catch(e){
      print(e);
    }
    return false;
  }

//===============delete product===========
  Future<bool> deleteProduct(String id) async {
    try{
      String jwtToken = ProductSupplierController.jwtToken;

      if (jwtToken.isEmpty) {
        jwtToken = await ProductSupplierController.fetchJwtToken(ProductSupplierController
            .currentEmail); // Fetch the JWT token if it's empty
      }
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      };
      var url = Uri.parse('${BASE_URL}products/$id');
      http.Response response =
          await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        print('Post success');
        fetchProductBySupplierId();
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      print(e);
    }
    return false;
  }

    //==============get producct by id================
  Future<void> getProductById(String id) async{
    String jwtToken = ProductSupplierController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await ProductSupplierController.fetchJwtToken(
          ProductSupplierController.currentEmail); // Fetch the JWT token if it's empty
    }
      http.Response response = await http.get(Uri.parse(
        '${BASE_URL}products/$id'),
        headers: {
          'Authorization': 'Bearer $jwtToken'
        }
        );
      if(response.statusCode == 200){
        //data successfully
        var result = jsonDecode(response.body);
        productModel = Product.fromJson(result);
        productNameTextController.text = result['productName']; 
        productDesTextController.text = result['description']; 
        productStatusTextController.text = result['status']; 
        categoryModel = result['category'];
        productCategoryTextController.text = categoryModel!.id; 
        productResellPriceTextController.text = result['resellPrice']; 
        productRetailPriceTextController.text = result['retailPrice'];
    }
    else{
      throw Exception('Failed to fetch suppliers');
    }    
  } 

  //==============update Product=============
  Future<bool> updateProduct(String id) async{
    try{
      String jwtToken = ProductSupplierController.jwtToken;

      if (jwtToken.isEmpty) {
        jwtToken = await ProductSupplierController.fetchJwtToken(ProductSupplierController
            .currentEmail); // Fetch the JWT token if it's empty
      }
      //multipart request
      var request = http.MultipartRequest(
        'PUT', Uri.parse('${BASE_URL}products')
      );
      Map<String, String> headers = {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type' : 'multipart/form-data'
      };
      //them file
      request.files.add( await
        http.MultipartFile.fromBytes(
          'File',
          selectedFile!,
          filename: filename,
          contentType: MediaType('image', 'png')
        )
      );
      //add header
      request.headers.addAll(headers);
      //add field
      request.fields.addAll({
        'CategoryId' : productCategoryTextController.text,
        'ProductName' : productNameTextController.text,
        'ResellPrice' : productResellPriceTextController.text,
        'RetailPrice' : productRetailPriceTextController.text,
        'Description' : productDesTextController.text,
        'Status' : productStatusTextController.text,
        'ProductId': id
      });

      //send request
      var response = await request.send();

      //check statusCode
      if(response.statusCode == 204){
        fetchProductBySupplierId();
        return true;
      }
      return false;
    }
    catch(e){
    }
    return false;
  }
}
