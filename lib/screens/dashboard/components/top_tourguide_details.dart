import 'package:admin/dto/toptourguide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class TopTourGuideDetails extends StatelessWidget {
  const TopTourGuideDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Top Tour Guides",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.blue
              ),
            ),
          ),
          SizedBox(height: defaultPadding),

          Obx(() => Column(
                children: tourGuideController.topTourGuide.value
                    .map((value) => TopTourGuideWidget(
                          name: value.name,
                          numberOfOrderCompleted:
                              value.reportInMonth.numberOfOrderCompleted,
                          point: value.reportInMonth.point,
                        ))
                    .toList(),
              )),
        ],
      ),
    );
  }
}
