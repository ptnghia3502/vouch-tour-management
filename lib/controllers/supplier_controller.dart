import 'dart:convert';

import 'package:admin/models/global.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Authentication/sharedPreferencesManager.dart';
import '../models/supplier_model.dart';
import '../routing/route_names.dart';

class SupplierController extends GetxController {
  static SupplierController instance = Get.find();
  //paging
  var currentPage = 1.obs;
  final itemsPerPage = 10;
  //searching
  var supplierList = <Supplier>[].obs;
  var foundsupplierList = <Supplier>[].obs;
  //
  static String jwtToken = '';
  static String currentEmail = 'hieuvh0804@gmail.com';

  //sorting
  var isAscending = true.obs;
  var sortColumnIndex = 0.obs;

  //texteditingcontroller
  TextEditingController supplierIdTextController = TextEditingController();  
  TextEditingController supplierNameTextController = TextEditingController();
  TextEditingController supplierEmailTextController = TextEditingController();
  TextEditingController supplierAdressTextController = TextEditingController();
  TextEditingController supplierPhoneNumberTextController =
      TextEditingController();
  //get user login
  SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager();

  Supplier? supplierModel; 
  @override
  Future<void> onInit() async {
    if (sharedPreferencesManager.getString('access_token') != null) {
      super.onInit();
      fetchSupplier();
     } else {
      Get.offNamed(loginPageRoute);
    }
  }



  //=====================get all supplier======================
  void fetchSupplier() async {
    String? jwtToken = SupplierController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await sharedPreferencesManager.getString('access_token');
    }
    http.Response response = await http.get(Uri.parse('${BASE_URL}suppliers'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      final List<dynamic> supplierJson = jsonDecode(response.body);
      supplierList.value =
          supplierJson.map((json) => Supplier.fromJson(json)).toList();
      foundsupplierList.value =
          supplierJson.map((json) => Supplier.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch suppliers');
    }
  }

   void getSupplierById(String id) async {
    String? jwtToken = SupplierController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await sharedPreferencesManager.getString('access_token');
    }
    http.Response response = await http.get(Uri.parse('${BASE_URL}suppliers/${id}'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      var result = jsonDecode(response.body);
      supplierModel = Supplier.fromJson(result);
      supplierIdTextController.text = supplierModel!.id;
      supplierNameTextController.text = supplierModel!.supplierName!;
      supplierAdressTextController.text = supplierModel!.address!;
      supplierEmailTextController.text = supplierModel!.email!;
      supplierPhoneNumberTextController.text = supplierModel!.phoneNumber!;
    } else {
      throw Exception('Failed to fetch suppliers');
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
    foundsupplierList.sort((a, b) {
      if (columnIndex == 0) {
        return a.email!.compareTo(b.email!);
      } else if (columnIndex == 1) {
        return a.supplierName!.compareTo(b.supplierName!);
      } else if (columnIndex == 2) {
        return a.address!.compareTo(b.address!);
      }
      return 0;
    });

    if (!isAscending.value) {
      foundsupplierList = foundsupplierList.reversed.toList().obs;
    }
  }

  //=====================this method is searching======================
  void filterSupplier(String supplierName) {
    var results = [];
    if (supplierName.isEmpty) {
      results = supplierList;
    } else {
      results = supplierList
          .where((element) => element.supplierName
              .toString()
              .toLowerCase()
              .contains(supplierName.toLowerCase()))
          .toList();
    }
    foundsupplierList.value = results as List<Supplier>;
  }

  //=====================this method is paging======================
  List<Supplier> get paginatedSupplier {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    return supplierList.length >= endIndex 
            ? foundsupplierList.sublist(startIndex, endIndex)
            : foundsupplierList.sublist(startIndex);
  }

  void nextPage() {
    if (currentPage.value * itemsPerPage < supplierList.length){
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  //clear TextEditingController
  Future<void> clearTextController() async {
    supplierIdTextController.clear();
    supplierAdressTextController.clear();
    supplierEmailTextController.clear();
    supplierPhoneNumberTextController.clear();
    supplierNameTextController.clear();
  }

  //============================post supplier==================
  Future<bool> insertSupplier() async {
    try {
      if (supplierAdressTextController.text.isEmpty ||
          supplierEmailTextController.text.isEmpty ||
          supplierNameTextController.text.isEmpty ||
          supplierPhoneNumberTextController.text.isEmpty) {
        return false;
      } else {
        String? jwtToken = SupplierController.jwtToken;
        if (jwtToken.isEmpty) {
        jwtToken = await sharedPreferencesManager.getString('access_token');// Fetch the JWT token if it's empty
        }
        final Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken'
        };
        var url = Uri.parse('${BASE_URL}suppliers');
        Map body = {
          'email': supplierEmailTextController.text,
          'supplierName': supplierNameTextController.text,
          'address': supplierAdressTextController.text,
          'phoneNumber': supplierPhoneNumberTextController.text
        };

        http.Response response =
            await http.post(url, body: jsonEncode(body), headers: headers);
        if (response.statusCode == 201) {
          print('Post success');
          clearTextController();
          fetchSupplier();
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  //=====================delete supplier======================
  Future<bool> deleteSupplier(String id) async {
    try {
      String? jwtToken = SupplierController.jwtToken;

      if (jwtToken.isEmpty) {
      jwtToken = await sharedPreferencesManager.getString('access_token'); // Fetch the JWT token if it's empty
      }
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      };
      var url = Uri.parse('${BASE_URL}suppliers/$id');
      http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        print('Post success');
        fetchSupplier();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
