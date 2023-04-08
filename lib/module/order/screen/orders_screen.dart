import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/util/extensions/datetime_extension.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.orderTitle),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(Sizes.defaultPadding),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            constraints: const BoxConstraints(
              minHeight: 100,
            ),
            padding: const EdgeInsets.all(Sizes.defaultPadding),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: Sizes.boxRadius,
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
                          const Text(
                            'Chorn Kihong',
                            style: AppStyle.medium,
                          ),
                          Text(
                            'y7KJKGeMDPzUA63yiHO9'.toUpperCase(),
                            style: AppStyle.small
                                .copyWith(color: AppColors.lightColor),
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
                          style: AppStyle.small
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Name',
                          style: AppStyle.small
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Units',
                          style: AppStyle.small
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ...List.generate(
                      5,
                      (index) => TableRow(
                        decoration: BoxDecoration(
                            color: index.isEven
                                ? AppColors.deepBackgroundColor
                                : null),
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
                const Text(
                  'Total : 4\$',
                  style: AppStyle.medium,
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => 20.sh,
      ),
    );
  }
}
