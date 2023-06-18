import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../../../constant/resources.dart';

class CancelledOrder extends StatelessWidget {
  const CancelledOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(Sizes.defaultPadding),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text((index + 1).toString()),
          title: Text('#342AF24'),
        );
      },
      separatorBuilder: (context, index) => 20.sh,
    );
  }
}
