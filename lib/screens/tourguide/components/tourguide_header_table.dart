
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
class TourGuideHeaderTable extends StatelessWidget {
  const TourGuideHeaderTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Danh sách các tour guide",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.lightBlue,
                fontSize: 22
              ),
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),
      ],
    );
  }
}


