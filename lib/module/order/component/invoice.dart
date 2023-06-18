import 'package:aklo_cafe/util/extensions/datetime_extension.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

import '../../../constant/resources.dart';

class Invoice extends StatelessWidget {
  const Invoice({super.key});
  Widget _tableColumn(
    String text,
    bool control,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.tablePadding,
        ),
        child: Text(
          text,
          style: AppStyle.small.copyWith(
            color: control ? AppColors.lightColor : AppColors.txtLightColor,
          ),
          textAlign: TextAlign.left,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.defaultPadding),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: Sizes.boxBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chorn Kihong',
                      style: AppStyle.medium,
                    ),
                    Text(
                      'y7KJKGeMDPzUA63yiHO9'.toUpperCase(),
                      style:
                          AppStyle.small.copyWith(color: AppColors.lightColor),
                    ),
                  ],
                ),
              ),
              Text(
                DateTime.now().displayDateTime,
                style: AppStyle.small,
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Sizes.defaultPadding.sh,
          Table(
            columnWidths: const {
              0: FlexColumnWidth(0.2),
            },
            // border: TableBorder.all(
            //   width: 0.1,
            //   color: AppColors.secondaryColor,
            // ),
            children: [
              TableRow(
                children: [
                  Text(
                    'No.',
                    style: AppStyle.small.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Name',
                    style: AppStyle.small.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Units',
                    style: AppStyle.small.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ...List.generate(
                5,
                (index) => TableRow(
                  decoration: BoxDecoration(
                      color:
                          index.isEven ? AppColors.deepBackgroundColor : null),
                  children: [
                    _tableColumn(' ${index + 1}', index.isOdd),
                    _tableColumn('Tnol Frappe', index.isOdd),
                    _tableColumn('12', index.isOdd),
                  ],
                ),
              ),
            ],
          ),
          10.sh,
          Text(
            'Total : 4\$',
            style: AppStyle.medium,
          )
        ],
      ),
    );
  }
}