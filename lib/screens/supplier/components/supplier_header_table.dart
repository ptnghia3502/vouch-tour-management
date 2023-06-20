
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
class SupplierHeaderTable extends StatelessWidget {
  const SupplierHeaderTable({
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
              "Danh sách các nhà cung cấp",
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
              onPressed: () {
                showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Center(child: Text('Leaderboard')),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          );},
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          ],
        ),
      ],
    );
  }
}


