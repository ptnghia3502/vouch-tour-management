import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'card_item.dart';

class CardsList extends StatelessWidget {
  const CardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Obx(() => 
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CardItem(
              icon: Icons.monetization_on_outlined,
              title: "Supplier",
              subtitle: "Supplier this month",
              value: "${supplierController.supplierList.value.length}",
              color1: primaryColor,
              color2: primaryColor,
            ),
            CardItem(
              icon: Icons.shopping_basket_outlined,
              title: "TourGuide",
              subtitle: "TourGuide this month",
              value: "${tourGuideController.tourguideList.value.length}",
              color1: Colors.blueAccent,
              color2: Colors.blueAccent
            ),
            CardItem(
              icon: Icons.delivery_dining,
              title: "Product",
              subtitle: "Total products on store",
              value: "${productController.productList.value.length}",
              color1: Color(0xFF26E5FF),
              color2: Color(0xFF26E5FF),
            ),
          ],
        ),
      ),
      )
    );
  }
}