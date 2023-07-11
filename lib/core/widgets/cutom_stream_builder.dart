import 'package:flutter/material.dart';

class CustomStreamBuilder<T> extends StatelessWidget {
  final Stream<T>? stream;
  final Widget? child;
  const CustomStreamBuilder({super.key, required this.stream, this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {}
        return child ?? SizedBox.shrink();
      },
    );
  }
}
