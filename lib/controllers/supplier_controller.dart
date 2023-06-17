import 'dart:convert';
import 'dart:math';

import 'package:admin/models/supplier.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class SupplierController extends GetxController{
  var isLoading = false.obs;
  var supplierList = <Supplier>[].obs;
  
  Supplier? supplierModel;

  @override
  Future<void> onInit() async{
    super.onInit();
    fetchData();
  }

   void fetchData() async{
      var token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySWQiOiJmYjAxZmJhZC0zNTg0LTQ2NDQtOTZkZC1lMmI2YzY1NTM2MDkiLCJFbWFpbCI6ImhpZXV2aDA4MDRAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE2ODcwMDYxMDMsImlzcyI6ImJjaGNiY2hhc2RrYWNhbXNjbmFza2RsbmFzZG1hc2xjYXNsZHNhbmFsY2FzbG5kYXNjbWxhc2tzYW5jIiwiYXVkIjoiYmNoY2JjaGFzZGthY2Ftc2NuYXNrZGxuYXNkbWFzbGNhc2xkc2FuYWxjYXNsbmRhc2NtbGFza3NhbmMifQ.bGiJ0oT_YMcZGRTdcmoaDBxpR2uLoiDV_ex21qZ8zSE";
      http.Response response = await http.get(Uri.parse(
        'https://vouch-tour-apis.azurewebsites.net/api/suppliers'),
        headers: {
          'Authorization': 'Bearer $token'
        }
        );
      if(response.statusCode == 200){
        //data successfully
        final List<dynamic> supplierJson = jsonDecode(response.body);
        supplierList.value = supplierJson.map((json) => Supplier.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to fetch suppliers');
    }
  }
}