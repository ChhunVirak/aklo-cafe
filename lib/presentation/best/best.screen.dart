import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/best.controller.dart';

class BestScreen extends GetView<BestController> {
  const BestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BestScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BestScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
