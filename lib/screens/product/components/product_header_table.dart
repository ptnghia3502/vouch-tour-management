import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class ProductHeaderTable extends StatelessWidget {
  const ProductHeaderTable({
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
              "Danh sách sản phẩm ",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.lightBlue, fontSize: 22),
            ),
          
          ],
        ),
      ],
    );
  }
}
