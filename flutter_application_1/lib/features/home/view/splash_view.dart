import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/view/home_view.dart';
import 'package:flutter_application_1/res/assets.dart';

class SplashView extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void navigateToHome() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, HomeView.routeName);
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(Assets.logoImage),
      ),
    );
  }
}
