import 'dart:convert';
import 'dart:typed_data';
import 'package:admin/constants.dart';
import 'package:admin/models/global.dart';
import 'package:admin/models/category_model.dart';
import 'package:admin/routing/route_names.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../Authentication/sharedPreferencesManager.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  //paging
  var currentPage = 1.obs;
  final itemsPerPage = 10;

  //
  Category? categoryModel;
  List<Category>? categories;
  var categoryList = <Category>[].obs;
  var foundCategoryList = <Category>[].obs;

  //
  // String? jwtToken = '';
  //  static String currentEmail = 'hieuvh0804@gmail.com';
  String? jwtToken = '';
  static String supplierId = '';
  // static String currentEmail = 'thyvnse162031@fpt.edu.vn';

  //sorting
  var sortColumnIndex = 0.obs;
  var isAscending = true.obs;

  //upload image
  List<int>? selectedFile;
  Uint8List? bytesData;
  String? filename;

  //textEditingController
  TextEditingController categoryNameTextController = TextEditingController();
  TextEditingController categoryIdTextContoller = TextEditingController();
  //get user login
  SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager();

  @override
  Future<void> onInit() async {
    if (sharedPreferencesManager.getString('access_token') != null) {
      super.onInit();
      fetchCategory();
    } else {
      Get.offNamed(loginPageRoute);
    }
  }

  

//==============get all category=============
  void fetchCategory() async {
    jwtToken = sharedPreferencesManager.getString('access_token');
    http.Response response = await http.get(Uri.parse('${BASE_URL}categories'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      final List<dynamic> categoryJson = jsonDecode(response.body);
      categoryList.value =
          categoryJson.map((json) => Category.fromJson(json)).toList();
      foundCategoryList.value =
          categoryJson.map((json) => Category.fromJson(json)).toList();
      categories = categoryJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch suppliers');
    }
  }

  //===================sorting===============
  Future<void> sortList(int columnIndex) async {
    if (sortColumnIndex.value == columnIndex) {
      //Reverse the sort order if the same column is clicked again
      isAscending.value = !isAscending.value;
    } else {
      //sort the list in ascending order by default when a new column is clicked
      sortColumnIndex.value = columnIndex;
      isAscending.value = true;
    }
    foundCategoryList.sort((a, b) {
      if (columnIndex == 1) {
        return a.categoryName!.compareTo(b.categoryName!);
      }
      return 0;
    });

    if (!isAscending.value) {
      foundCategoryList = foundCategoryList.reversed.toList().obs;
    }
  }

  //search
  void filterCategory(String categoryName) {
    var results = [];
    if (categoryName.isEmpty) {
      results = categoryList;
    } else {
      results = categoryList
          .where((element) => element.categoryName
              .toString()
              .toLowerCase()
              .contains(categoryName.toLowerCase()))
          .toList();
    }
    foundCategoryList.value = results as List<Category>;
  }

  //=====================this method is paging======================
  List<Category> get paginatedCategory {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    return categoryList.length >= endIndex
        ? foundCategoryList.sublist(startIndex, endIndex)
        : foundCategoryList.sublist(startIndex);
  }

  void nextPage() {
    if (currentPage.value * itemsPerPage < categoryList.length) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  //clear textcontroller
  Future<void> clearTextController() async {
    categoryNameTextController.clear();
    categoryIdTextContoller.clear();
    bytesData = null;
  }

  //==================insert Category==============
  Future<bool> insertCategory() async {
    try {
      jwtToken = sharedPreferencesManager.getString('access_token');
      //MultiPart request
      var request =
          http.MultipartRequest('POST', Uri.parse('${BASE_URL}categories'));
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
        'CategoryName': categoryNameTextController.text,
      });
      //send the request
      var response = await request.send();

      //check the response status
      if (response.statusCode == 201) {
        fetchCategory();
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
    return false;
  }


  //===============delete category===========
  Future<bool> deleteCategory(String id) async {
    try {
      jwtToken = sharedPreferencesManager.getString('access_token');
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      };
      var url = Uri.parse('${BASE_URL}categories/$id');
      http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        print('Post success');
        fetchCategory();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }


  //==============get Category by id================
  Future<void> getCategoryById(String id) async {
    jwtToken = sharedPreferencesManager.getString('access_token');
    http.Response response = await http.get(
        Uri.parse('${BASE_URL}categories/$id'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      var result = jsonDecode(response.body);
      categoryModel = Category.fromJson(result);
      categoryNameTextController.text = result['categoryName'];
      categoryIdTextContoller.text = result['id'];
      // http.Response urlReponse = await http.get(Uri.parse(categoryModel!.url));
      List<int> encodeData = (categoryModel!.url)!.codeUnits;
      bytesData = Uint8List.fromList(encodeData);
    } else {
      throw Exception('Failed to fetch category');
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
          .addAll({'CategoryName': categoryNameTextController.text, 'Id': id});

      //send request
      var response = await request.send();

      //check statusCode
      if (response.statusCode == 204) {
        fetchCategory();
        return true;
      }
      return false;
    } catch (e) {}
    return false;
  }
}
