import 'package:flutter/material.dart';

class ScreenChooseRole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // navigate to dashboard of Administration
            },
            child: Text('Admin'),
          ),
          SizedBox(width: 16), // Adjust the spacing between buttons
          ElevatedButton(
            onPressed: () {
              // navigate to dashboard of Shop Manager
            },
            child: Text('Shop Manager'),
          ),
        ],
      ),
    );
  }
}
