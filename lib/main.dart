import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/constance/app_color.dart';
import 'package:flutter_todo_app/feature/home/home.dart';
import 'package:flutter_todo_app/feature/todo/create_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryLight,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.secondaryLight,
        ),
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryLight,
          secondary: AppColors.secondaryLight,
        ),
        textTheme: TextTheme(bodyMedium: TextStyle(color: AppColors.textLight)),
      ),
      // Dark theme
      darkTheme: ThemeData(
        primaryColor: AppColors.primaryDark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.secondaryDark,
        ),
        colorScheme: ColorScheme.dark(
          primary: AppColors.primaryDark,
          secondary: AppColors.secondaryDark,
        ),
        textTheme: TextTheme(bodyMedium: TextStyle(color: AppColors.textDark)),
      ),
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/create': (context) => const CreateTodo(),
      },
    );
  }
}
