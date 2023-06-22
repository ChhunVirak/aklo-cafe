import 'package:aklo_cafe/module/client/model/order_model.dart';
import 'package:aklo_cafe/util/extensions/datetime_extension.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/function/format_function.dart';
import 'package:flutter/material.dart';

import '../../../constant/resources.dart';

class Invoice extends StatelessWidget {
  final OrderModel orderModel;
  const Invoice({
    super.key,
    required this.orderModel,
  });
  Widget _tableColumn(
    String text,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.tablePadding,
        ),
        child: Text(
          text,
          style: AppStyle.small.copyWith(
            color: AppColors.lightColor,
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
                      'Kihong',
                      style: AppStyle.medium,
                    ),
                    Text(
                      orderModel.id.toString().toUpperCase(),
                      style:
                          AppStyle.small.copyWith(color: AppColors.lightColor),
                    ),
                  ],
                ),
              ),
              Text(
                orderModel.orderDate.displayDateTime,
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
                orderModel.products.length,
                (index) => TableRow(
                  children: [
                    _tableColumn(' ${index + 1}'),
                    _tableColumn(orderModel.products[index].name),
                    _tableColumn(orderModel.products[index].amount.toString()),
                  ],
                ),
              ),
            ],
          ),
          10.sh,
          Text(
            'Total : \$${formatCurrency(orderModel.total)}',
            style: AppStyle.medium,
          )
        ],
      ),
    );
  }
}
