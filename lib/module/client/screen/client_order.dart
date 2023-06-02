import 'package:flutter/material.dart';

import '../../inventory/inventory.dart';

class ClientOrderScreen extends StatelessWidget {
  const ClientOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AllCoffeeScreen(),
          ),
        ],
      ),
    );
  }
}
