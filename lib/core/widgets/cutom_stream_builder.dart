import 'package:flutter/material.dart';

class StreamBuilderWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(AsyncSnapshot<T> snapshot) onLoading;
  final Widget Function(dynamic error) onError;
  final Widget Function() onDone;

  const StreamBuilderWidget({
    super.key,
    required this.stream,
    required this.onLoading,
    required this.onError,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return onLoading(snapshot);
        } else if (snapshot.hasError) {
          return onError(snapshot.error);
        } else if (snapshot.connectionState == ConnectionState.done) {
          return onDone();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
