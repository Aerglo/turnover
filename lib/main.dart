import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:turnover/Data/DataBase/turnover_model.dart';
import 'package:turnover/Presentation/Pages/add_turnover_page.dart';
import 'package:turnover/Presentation/Pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TurnoverAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        '/': (p0) => const HomePage(),
        '/addTurnover': (p0) => const AddTurnover(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
