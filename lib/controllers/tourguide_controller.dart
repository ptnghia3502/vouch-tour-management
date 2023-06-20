import 'dart:convert';

import 'package:admin/models/global.dart';
import 'package:admin/models/tourguide_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class TourGuideController extends GetxController{
  static TourGuideController instance = Get.find();
  var tourguideList = <TourGuide>[].obs;
  var foundTourGuide = <TourGuide>[].obs;
  TextEditingController searchController = TextEditingController();
  static String jwtToken = '';
  static String currentEmail = 'hieuvh0804@gmail.com';
  

  @override
  Future<void> onInit() async{
    super.onInit();
    fetchTourGuide();
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
    }
    else if (response.statusCode == 401) {
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

   void fetchTourGuide() async{
    String jwtToken = TourGuideController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await TourGuideController.fetchJwtToken(
          TourGuideController.currentEmail); // Fetch the JWT token if it's empty
    }
      http.Response response = await http.get(Uri.parse(
        '${BASE_URL}tour-guides'),
        headers: {
          'Authorization': 'Bearer $jwtToken'
        }
        );
      if(response.statusCode == 200){
        //data successfully
        final List<dynamic> tourguideJson = jsonDecode(response.body);
        tourguideList.value = tourguideJson.map((json) => TourGuide.fromJson(json)).toList();
        foundTourGuide.value = tourguideJson.map((json) => TourGuide.fromJson(json)).toList();
    }
    else{
      throw Exception('Failed to fetch suppliers');
    }
  }

  void filterTourGuide(String tourguideName){
    var results = [];
    if(tourguideName.isEmpty){
      results = tourguideList;
    }
    else{
      results = tourguideList.where((element) => element.name.toString().toLowerCase().contains(tourguideName.toLowerCase())).toList();
    }
    foundTourGuide.value = results as List<TourGuide>;
  }
}