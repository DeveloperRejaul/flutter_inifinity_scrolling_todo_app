// lib/core/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/feature/home/home.dart';
import 'package:flutter_todo_app/feature/todo/update_todo.dart';

class AppRoutes {
  static const String home = '/';
  static const String updateTodo = '/update';
  static const String addTodo = '/add';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const Home());

      case updateTodo:
        final args = settings.arguments as Map<String, dynamic>?;

        if (args != null && args.containsKey('id')) {
          return MaterialPageRoute(builder: (_) => UpdateTodo(id: args['id']));
        }
        return _errorRoute();

      // case addTodo:
      //   return MaterialPageRoute(builder: (_) => const AddTodo());

      // case settings:
      //   return MaterialPageRoute(builder: (_) => const SettingsPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page not found")),
      ),
    );
  }
}
