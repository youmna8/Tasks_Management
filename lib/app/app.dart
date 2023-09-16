import 'package:first_app/core/Theme/theme.dart';
import 'package:first_app/features/auth/presentation/screens/Splash_Screen/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: getAppTheme(),
     home: const SplashScreen());
      },
    );
  }
}
