import 'dart:html';
import 'dart:io';
import 'dart:io';

import 'package:admin/models/category_model.dart';
import 'package:admin/models/product_image_modal.dart';
import 'package:flutter/material.dart';

class CreateProductDTO {
  late String ProductName;
  late double ResellPrice;
  late double RetailPrice;
  late String Description;
  late String Status;
  late List<ProductImage> FileUrl;
  late String CategoryId;

  CreateProductDTO(
      {required this.ProductName,
      required this.ResellPrice,
      required this.RetailPrice,
      required this.Description,
      required this.Status,
      required this.FileUrl,
      required this.CategoryId});
  factory CreateProductDTO.fromJson(Map<String, dynamic> json) {
    return CreateProductDTO(
      ProductName: json['productName'],
      ResellPrice: json['resellPrice'],
      RetailPrice: json['retailPrice'],
      Description: json['description'],
      Status: json['status'],
      FileUrl: json['fileUrl'],
      CategoryId: json['categoryId'],
    );
  }
}
