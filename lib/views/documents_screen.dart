import 'package:flutter/material.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Documents',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Documents Screen - Coming Soon!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}