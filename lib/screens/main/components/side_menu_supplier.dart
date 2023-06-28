import 'package:admin/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class SideMenuSupplier extends StatelessWidget {
  const SideMenuSupplier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/tour_logo.png",
            width: 25,
            height: 25,
            ),
            
          ),
          ListTile(
            title: Center(
              child: Text(
                  "GIAO HÀNG"  ,
                  style: TextStyle(color: Colors.blueGrey),
              ),
            )
            ),
          DrawerListTile(
            title: "Đơn Hàng",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Get.back();
              navigationController.navigateTo(ordersPageRoute);
            },
          ),
          DrawerListTile(
            title: "Thống kê",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Get.back();
              navigationController.navigateTo(dashboardPageRoute);
            },
          ),
          ListTile(
            title: Center(
              child: Text(
                  "HỆ THỐNG"  ,
                  style: TextStyle(color: Colors.blueGrey),
              ),
            )
            ),
          DrawerListTile(
            title: "Sản Phẩm",
            svgSrc: "assets/icons/menu_product.svg",
            press: () {
              Get.back();
              navigationController.navigateTo(productsPageRoute);
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
