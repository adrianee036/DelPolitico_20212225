import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';
import 'util/audio_player.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('eventsdb');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          primaryColor: Color(
              int.parse('#a4947c'.substring(1, 7), radix: 16) + 0xFF000000),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.white70, foregroundColor: Colors.red[60]),
          appBarTheme: AppBarTheme(
              color: Color(
                  int.parse('#a4947c'.substring(1, 7), radix: 16) + 0xFF000000),
              foregroundColor: Colors.white),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
    );
  }
}
