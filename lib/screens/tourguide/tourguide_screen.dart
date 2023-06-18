import 'package:admin/responsive.dart';
import 'package:admin/screens/tourguide/components/tourguide_table.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../tourguide/components/header.dart';
import 'components/tourguide_header_table.dart';


class TourGuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      TourGuideHeaderTable(),
                      SizedBox(height: defaultPadding),
                      
                      TourGuideTable(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      // if (Responsive.isMobile(context)) StorageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
              ],
            )
          ],
        ),
      ),
    );
  }
}
