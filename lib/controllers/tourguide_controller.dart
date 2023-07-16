import 'dart:convert';

import 'package:admin/models/global.dart';
import 'package:admin/models/tourguide_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Authentication/sharedPreferencesManager.dart';
import '../routing/route_names.dart';

class TourGuideController extends GetxController {
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
  String? jwtToken = '';
  //static String currentEmail = 'hieuvh0804@gmail.com';

  //textEditing
  TextEditingController tourguideNameTextController = TextEditingController();
  TextEditingController tourguideEmailTextController = TextEditingController();
  TextEditingController tourguidePhoneNumerTextController =
      TextEditingController();
  TextEditingController tourguideSexTextController = TextEditingController();
  TextEditingController tourguideBirthDayTextController =
      TextEditingController();
  TextEditingController tourguideAddressTextController =
      TextEditingController();
      String? selectGender = 'Nam';

  //TourGuid Model
  TourGuide? touGuideModel;

  //filtering
  final selectedGender = 'Nam'.obs;
  List<String> listGender = <String>['Nam', 'Nữ'];
  //get user login
  SharedPreferencesManager sharedPreferencesManager =
      SharedPreferencesManager();
  @override
  Future<void> onInit() async {
    if (sharedPreferencesManager.getString('access_token') != null) {
      super.onInit();
      fetchTourGuide();
    } else {
      Get.offNamed(loginPageRoute);
    }
  }

  Future<void> setSelectedGender(String value) async {
    selectedGender.value = value;
  }

  //====================get all tourguide=============
  void fetchTourGuide() async {
    jwtToken = sharedPreferencesManager.getString('access_token');
    http.Response response = await http.get(Uri.parse('${BASE_URL}tour-guides'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      final List<dynamic> tourguideJson = jsonDecode(response.body);
      tourguideList.value =
          tourguideJson.map((json) => TourGuide.fromJson(json)).toList();
      foundTourGuide.value =
          tourguideJson.map((json) => TourGuide.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch tourguide');
    }
  }

  //==============sorting=============
  Future<void> sortList(int columnIndex) async {
    if (sortColumnIndex.value == columnIndex) {
      //Reverse the sort order if the same column is clicked again
      isAscending.value = !isAscending.value;
    } else {
      //sort the list in ascending order by default when a new column is clicked
      sortColumnIndex.value = columnIndex;
      isAscending.value = true;
    }
    foundTourGuide.sort((a, b) {
      if (columnIndex == 0) {
        return a.name.compareTo(b.name);
      } else if (columnIndex == 1) {
        return a.sex.compareTo(b.sex);
      } else if (columnIndex == 3) {
        return a.email.compareTo(b.email);
      } 
      return 0;
    });

    if (!isAscending.value) {
      foundTourGuide = foundTourGuide.reversed.toList().obs;
    }
  }

  //==============searching============
  void filterTourGuide(String tourguideName) {
    var results = [];
    if (tourguideName.isEmpty) {
      results = tourguideList;
    } else {
      results = tourguideList
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(tourguideName.toLowerCase()))
          .toList();
    }
    foundTourGuide.value = results as List<TourGuide>;
  }

  //this method is paging
  List<TourGuide> get paginatedTourGuide {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    return tourguideList.length >= endIndex
        ? foundTourGuide.sublist(startIndex, endIndex)
        : foundTourGuide.sublist(startIndex);
  }

  void nextPage() {
    if (currentPage.value * itemsPerPage < tourguideList.length) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

  //clear text
  Future<void> clearTextController() async {
    this.tourguideAddressTextController.clear();
    this.tourguideBirthDayTextController.clear();
    this.tourguideEmailTextController.clear();
    this.tourguideNameTextController.clear();
    this.tourguideSexTextController.clear();
    this.tourguidePhoneNumerTextController.clear();
  }

  //======================create tourguide==============
  Future<bool> insertTourGuide() async {
    try {
      jwtToken = sharedPreferencesManager.getString('access_token');

      // if (jwtToken.isEmpty) {
      //   jwtToken = await TourGuideController.fetchJwtToken(
      //       TourGuideController.currentEmail);
      // }

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };

      var url = Uri.parse('${BASE_URL}tour-guides');
      Map body = {
        'email': this.tourguideEmailTextController.text,
        'name': this.tourguideNameTextController.text,
        'dateOfBirth': this.tourguideBirthDayTextController.text,
        'sex': this.selectGender == 'Nam' ? 0 : 1,
        'address': this.tourguideAddressTextController.text,
        'phoneNumber': this.tourguidePhoneNumerTextController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 201) {
        print('Post Tour-Guide Success');
        clearTextController();
        fetchTourGuide();
        return true;
      } else {
        return false;
      }
    } catch (e) {}
    return false;
  }

  //===================delete tourguide==========
  Future<bool> deleteTourGuide(String id) async {
    try {
      jwtToken = sharedPreferencesManager.getString('access_token');

      // if (jwtToken.isEmpty) {
      //   jwtToken = await TourGuideController.fetchJwtToken(TourGuideController
      //       .currentEmail); // Fetch the JWT token if it's empty
      // }
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken'
      };
      var url = Uri.parse('${BASE_URL}tour-guides/$id');
      http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        print('Delete TourGuide success');
        fetchTourGuide();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  //==============get Tourguid by id================
  Future<void> getCategoryById(String id) async {
    jwtToken = sharedPreferencesManager.getString('access_token');
    http.Response response = await http.get(
        Uri.parse('${BASE_URL}categories/$id'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      var result = jsonDecode(response.body);
      touGuideModel = TourGuide.fromJson(result);
      tourguideNameTextController.text = result['tourGuideName'];
      // http.Response urlReponse = await http.get(Uri.parse(categoryModel!.url));
      // bytesData = urlReponse.bodyBytes;
    } else {
      throw Exception('Failed to fetch suppliers');
    }
  }
}
