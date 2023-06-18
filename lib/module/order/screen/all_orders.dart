import 'package:aklo_cafe/config/router/app_pages.dart';
import 'package:aklo_cafe/util/extensions/datetime_extension.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../../../constant/resources.dart';

class AllOrder extends StatelessWidget {
  const AllOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(Sizes.defaultPadding),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            pushSubRoute('#001');
          },
          subtitle: Text(DateTime.now().displayDateTime),
          leading: Text((index + 1).toString()),
          title: Text('#342AF24'),
        );
      },
      separatorBuilder: (context, index) => 20.sh,
    );
  }
}
