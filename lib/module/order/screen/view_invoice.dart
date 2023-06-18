import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../component/invoice.dart';

class ViewInvoice extends StatelessWidget {
  final String? id;
  const ViewInvoice({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id.toString()),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(
          bottom: Sizes.defaultPadding,
          left: Sizes.defaultPadding,
          right: Sizes.defaultPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Invoice(),
            ),
            10.sh,
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    PhosphorIcons.x_circle_bold,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
                10.sw,
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    name: 'Accept',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
