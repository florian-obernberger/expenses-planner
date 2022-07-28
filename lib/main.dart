import 'package:expenses_planner/home_page.dart';
import 'package:flutter/material.dart';
import 'package:expenses_planner/material_you/material_you_builder.dart';
import 'package:expenses_planner/theme/color_schemes.dart';
import 'package:expenses_planner/theme/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialYouBuilder(
      colorScheme: lightColorScheme,
      darkColorScheme: darkColorScheme,
      builder: (context, lightColorScheme, darkColorScheme) {
        return MaterialApp(
          title: 'Expenses Planner',
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            textTheme: textTheme,
            colorScheme: lightColorScheme,
            canvasColor: lightColorScheme.surface,
            disabledColor: lightColorScheme.outline.withOpacity(0.38),
            dialogBackgroundColor: lightColorScheme.surface,
            scaffoldBackgroundColor: lightColorScheme.background,
            unselectedWidgetColor: lightColorScheme.onSurface,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            textTheme: textTheme,
            colorScheme: darkColorScheme,
            canvasColor: darkColorScheme.surface,
            disabledColor: darkColorScheme.outline.withOpacity(0.38),
            dialogBackgroundColor: darkColorScheme.surface,
            scaffoldBackgroundColor: darkColorScheme.background,
            unselectedWidgetColor: darkColorScheme.onSurface,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
