import 'package:flutter/material.dart';

import 'screens/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
