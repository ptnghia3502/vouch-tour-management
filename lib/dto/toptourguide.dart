import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
class TopTourGuideWidget extends StatelessWidget {

  const TopTourGuideWidget({
    Key? key,
    required this.name,
    required this.numberOfOrderCompleted,
    required this.point
  }) : super(key: key);

  final String name;
  final int numberOfOrderCompleted;
  final int point;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset('assets/icons/menu_tourguide.svg'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                   '${this.numberOfOrderCompleted}, completed orders',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          Text('${this.point} points')
        ],
      ),
    );
  }
}

