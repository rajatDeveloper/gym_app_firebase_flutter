import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/category/view/category_view.dart';

class CatWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  const CatWidget({super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryView.routeName, arguments: title);
      },
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 80,
            height: 80,
          ),
          Text(title),
        ],
      ),
    );
  }
}
