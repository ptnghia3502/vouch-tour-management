import 'dart:convert';
import 'dart:ui';

import 'package:admin/models/supplier_report_model.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/MyFiles.dart';
import '../models/global.dart';
import 'package:http/http.dart' as http;

class SupplierReportController extends GetxController {
  static SupplierReportController instance = Get.find();

  var supplierReportList = <SupplierReport>[].obs;
  SupplierReport? supplierReportModel;

  List? demoMyFiles; 

  static String jwtToken = '';
  static String supplierId = '';
  static String currentEmail = 'CauBeThoiTiet@gmail.com';

    @override
  Future<void> onInit() async {
    super.onInit(); 
    fetchReportBySupplierId();
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
  //==================get all report============
  void fetchReportBySupplierId() async{
    String jwtToken = SupplierReportController.jwtToken;

    if (jwtToken.isEmpty) {
      jwtToken = await SupplierReportController.fetchJwtToken(
          SupplierReportController.currentEmail); // Fetch the JWT token if it's empty
    }
    http.Response response = await http.get(Uri.parse('${BASE_URL}suppliers/$supplierId/suppliers-report'),
        headers: {'Authorization': 'Bearer $jwtToken'});
    if (response.statusCode == 200) {
      //data successfully
      var result = jsonDecode(response.body);
      supplierReportModel = SupplierReport.fromJson(result);
      demoMyFiles = [
                ReportInfo(
                  title: "Số Lượng Sản Phẩm",
                  numof: supplierReportModel?.numberOfProducts,
                  svgSrc: "assets/icons/menu_product.svg",
                  color: primaryColor,
                ),
                ReportInfo(
                  title: "Số Lượng Đơn Hàng",
                  numof: supplierReportModel?.numberOfOrder,
                  svgSrc: "assets/icons/google_drive.svg",
                  color: Color(0xFFFFA113),
                ),
                ReportInfo(
                  title: "Tổng Tiền Bán Được",
                  numof: supplierReportModel!.totalMoneySold.toInt(),
                  svgSrc: "assets/icons/menu_task.svg",
                  color: Color(0xFFA4CDFF),
                ),
              ];
      
    } else {
      throw Exception('Failed to fetch product');
    }
  }


} 

class ReportInfo{
  final String? svgSrc, title;
  final int? numof;
  final Color? color;

  ReportInfo({
    this.svgSrc,
    this.title,
    this.numof,
    this.color
  });
}