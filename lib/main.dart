import 'package:flutter/material.dart';
import 'package:e_shamber/screens/new_home.dart';
import 'package:e_shamber/screens/page_dash.dart';

void main() {
  enablePlatformOverrideForDesktop();
  runApp(MyApp());
}
//void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Mermidon App',
      home: HomePage(),//NewHomePage(),//HomePage()
    );
  }
}




