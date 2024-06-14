import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/task.dart';
import './screens/homepage.dart';

void main() => runApp(const ToDoListApp());

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF3A3939),
          primaryColor: const Color(0xFF9FEEE5),
          colorScheme: ColorScheme.fromSwatch(
            brightness: Brightness.dark,
            primarySwatch: createMaterialColor(const Color(0xFF9FEEE5)),
          ).copyWith(
            secondary: const Color(0xFF9FEEE5),
            surface: const Color(0xFF3A3939),
          ),
          textTheme: ThemeData.dark().textTheme.copyWith(
                titleLarge: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
                titleSmall: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                bodyLarge: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 16,
                ),
                bodyMedium: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 14,
                ),
                bodySmall: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 12,
                ),
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF3A3939),
            toolbarTextStyle: ThemeData.dark()
                .textTheme
                .copyWith(
                  titleLarge: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .bodyMedium,
            titleTextStyle: ThemeData.dark()
                .textTheme
                .copyWith(
                  titleLarge: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .titleLarge,
          ),
        ),
        title: 'To Do List',
        home: const Homepage(),
      ),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
