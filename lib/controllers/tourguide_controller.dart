import 'dart:convert';

import 'package:admin/models/global.dart';
import 'package:admin/models/tourguide_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class TourGuideController extends GetxController{
  static TourGuideController instance = Get.find();
  //
  var tourguideList = <TourGuide>[].obs;
  var foundTourGuide = <TourGuide>[].obs;
  
  //paging and searching
  var currentPage = 1.obs;
  var itemsPerPage = 5;
  TextEditingController searchController = TextEditingController();

  //sorting
  var sortColumnIndex = 0.obs;
  var isAscending = true.obs;

  //authorization
  static String jwtToken = '';
  static String currentEmail = 'hieuvh0804@gmail.com';

  //textEditing
  TextEditingController tourguideNameTextController = TextEditingController();
  TextEditingController tourguideEmailTextController = TextEditingController();
  TextEditingController tourguidePhoneNumerTextController = TextEditingController();
  TextEditingController tourguideSexTextController = TextEditingController();
  TextEditingController tourguideBirthDayTextController = TextEditingController();
  TextEditingController tourguideAddressTextController = TextEditingController();

  //filtering
  final selectedGender = 'Nam'.obs;
  List<String> listGender = <String>['Nam','Nữ'];

  @override
  Future<void> onInit() async{
    super.onInit();
    fetchTourGuide();
  }

  Future<void> setSelectedGender(String value) async{
      selectedGender.value = value;
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
  //====================get all tourguide=============
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
  //==============sorting=============
  Future<void> sortList(int columnIndex) async{
    if(sortColumnIndex.value == columnIndex){
      //Reverse the sort order if the same column is clicked again
      isAscending.value = !isAscending.value;
    }
    else{
      //sort the list in ascending order by default when a new column is clicked
      sortColumnIndex.value = columnIndex;
      isAscending.value = true;
    }
    tourguideList.sort((a,b) {
      if(columnIndex == 0){
        return a.id.compareTo(b.id);
      } else if(columnIndex == 1){
        return a.name.compareTo(b.name);
      } else if(columnIndex == 2){
        return a.sex.compareTo(b.sex);
      } else if(columnIndex == 4){
        return a.email.compareTo(b.email);
      } else if(columnIndex == 7){
        return a.numberOfProductSold.compareTo(b.numberOfProductSold);
      } else if(columnIndex == 8){
        return a.numberOfGroup.compareTo(b.numberOfGroup);
      } else if(columnIndex == 9){
        return a.point.compareTo(b.point);
      }
      return 0;
    });

    if (!isAscending.value){
      tourguideList = tourguideList.reversed.toList().obs;
    }
  }

  //==============searching============
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

    //this method is paging
  List<TourGuide> get paginatedTourGuide{
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    return tourguideList.length >= endIndex 
            ? foundTourGuide.sublist(startIndex, endIndex)
            : foundTourGuide.sublist(startIndex);
  }

  void nextPage() {
    if (currentPage.value * itemsPerPage < tourguideList.length){
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }
    //clear text
    Future<void> clearTextController() async{
          this.tourguideAddressTextController.clear();
          this.tourguideBirthDayTextController.clear();
          this.tourguideEmailTextController.clear();
          this.tourguideNameTextController.clear();
          this.tourguideSexTextController.clear();
          this.tourguidePhoneNumerTextController.clear();
    }

    //======================post tourguide==============
    Future<bool> insertTourGuide() async {
      try{
        String jwtToken = TourGuideController.jwtToken;

        if(jwtToken.isEmpty){
          jwtToken = await TourGuideController.fetchJwtToken(
            TourGuideController.currentEmail
          );
        }

        final Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        };

        var url = Uri.parse('${BASE_URL}tour-guides');
        Map body = {
          'email': this.tourguideEmailTextController.text,
          'name' : this.tourguideNameTextController.text,
          'dateOfBirth': this.tourguideBirthDayTextController.text,
          'sex': this.tourguideSexTextController.text.trim() == 'Name' ? 0 : 1,
          'address': this.tourguideAddressTextController.text,
          'phoneNumber': this.tourguidePhoneNumerTextController.text
        };
        http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
        if(response.statusCode == 201){
          print('Post Sucess');
          clearTextController();
          fetchTourGuide();
          return true;
        }else{
          return false;
        }
      }
      catch(e)
      {
      }
      return false;
    }

    //===================delete tourguide==========
      Future<bool> deleteTourGuide(String id) async {
    try {
      String jwtToken = TourGuideController.jwtToken;

      if (jwtToken.isEmpty) {
        jwtToken = await TourGuideController.fetchJwtToken(TourGuideController
            .currentEmail); // Fetch the JWT token if it's empty
      }
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      };
      var url = Uri.parse('${BASE_URL}tour-guides/$id');
      http.Response response =
          await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        print('Post success');
        fetchTourGuide();
        return true;
      }
      else{
        return false;
      }
      
    } catch (e) {
      print(e);
    }
    return false;
  }
}