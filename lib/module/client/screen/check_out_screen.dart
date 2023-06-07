import 'package:flutter/material.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders #3403E2'),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          ListTile(
            title: Text('Hello'),
          )
        ],
      ),
    );
  }
}
