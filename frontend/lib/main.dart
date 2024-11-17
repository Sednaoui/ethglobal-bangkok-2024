import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kid_pay/ui/home_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>('redeemers:names');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KidPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(209, 232, 247, 1),
          surface: Color.fromRGBO(26, 27, 28, 1),
        ),
        scaffoldBackgroundColor: const Color.fromRGBO(17, 17, 17, 1),
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const HomePage(),
    );
  }
}
