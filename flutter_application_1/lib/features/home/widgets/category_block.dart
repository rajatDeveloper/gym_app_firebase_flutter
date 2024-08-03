import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/widgets/cat_widget.dart';
import 'package:flutter_application_1/res/assets.dart';

class CategoryBlock extends StatelessWidget {
  const CategoryBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return //Categories Wdget
        Container(
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CatWidget(iconPath: Assets.gymImage, title: "Gym"),
              CatWidget(iconPath: Assets.swimImage, title: "Swiming"),
              CatWidget(iconPath: Assets.yogaImage, title: "Yoga"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CatWidget(iconPath: Assets.badmintonImage, title: "Badminton"),
              CatWidget(iconPath: Assets.zumbaImage, title: "Zumba"),
              CatWidget(iconPath: Assets.yogaImage, title: "Yoga"),
            ],
          ),
        ],
      ),
    );
  }
}
