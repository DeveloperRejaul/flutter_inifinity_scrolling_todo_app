import 'package:flutter/material.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key});

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  @override
  Widget build(BuildContext context) {
    final String? args = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(centerTitle: false, title: Text("Update Product")),
      body: Center(child: Text(args ?? "Update product")),
    );
  }
}
