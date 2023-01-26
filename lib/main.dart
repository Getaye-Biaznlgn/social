import 'package:church_social_media/core/theme/custome_theme.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Social App',
        theme: CustomTheme.lightTheme(),
        darkTheme: CustomTheme.darkTheme(),
        themeMode: ThemeMode.system,
        home: const Placeholder());
  }
}
