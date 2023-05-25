import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/dependency_injection.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_colors.dart';
import 'package:robot_kitten_assessment/presentation/core/navigation.dart';
import 'package:robot_kitten_assessment/presentation/events/pages/events_list_page.dart';

void main() {
  configureDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.black,
        useMaterial3: true,
      ),
      home: const EventsListPage(),
    );
  }
}
