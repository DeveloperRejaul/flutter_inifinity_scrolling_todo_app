import 'package:flutter/material.dart';

class UpdateTodo extends StatelessWidget {
  final int id;
  const UpdateTodo({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Update Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'product_$id', // same tag as ListItem
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
