import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(360, 764),
      child: MaterialApp(localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ], supportedLocales: [
        Locale('en', 'US'),
        Locale('en', 'GB'),
      ], debugShowCheckedModeBanner: false, home: HomeScreen()),
    );
  }
}
