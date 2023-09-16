import 'package:first_app/core/Services/Service_Locator.dart';
import 'package:first_app/core/database/Cache/Cache_Helper.dart';

import 'package:first_app/core/utiles/app_assets.dart';
import 'package:first_app/core/utiles/app_colors.dart';
import 'package:first_app/core/utiles/app_srtings.dart';
import 'package:first_app/features/auth/presentation/screens/on_boarding_screens/on_boarding_screens.dart';
import 'package:first_app/features/task/presentation/screens/Home_Screen/Home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigat();
  }

  void navigat() {
    bool isVisted =
        sl<CacheHelper>().getData(key: AppString.onboarding) ?? false;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) =>isVisted? HomeScreen(): OnBoardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAsset.logo),
            SizedBox(
              height: 24,
            ),
            Text(
              AppString.appname,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(fontSize: 40),
            )
          ],
        )));
  }
}
