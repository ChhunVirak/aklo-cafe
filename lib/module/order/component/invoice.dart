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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Aklo Coffe and Tea',
            style: AppStyle.large,
          ),
          Text(
            'Takeo',
            style: AppStyle.small,
          ),
          Text(
            'RECEIPT',
            style: AppStyle.medium,
          ),
          Sizes.textPadding.sh,
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Kihong',
                //   style: AppStyle.medium,
                // ),
                Text(
                  'Receipt ID : ' + orderModel.id.toString().toUpperCase(),
                  style: AppStyle.small.copyWith(color: AppColors.lightColor),
                ),
                Text(
                  'Order Date : ' + orderModel.orderDate.displayDateTime,
                  style: AppStyle.small,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Sizes.textPadding.sh,
          Divider(color: AppColors.txtDarkColor, thickness: 0.7),
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
          Divider(color: AppColors.txtDarkColor, thickness: 0.7),
          Sizes.tablePadding.sh,
          TotalTitle(
            title: 'Total-QTY : ',
            value: orderModel.products.isNotEmpty
                ? '${orderModel.products.fold<num>(0, (a, b) => a + b.amount)}'
                : '',
          ),
          TotalTitle(
            title: 'Grand-Total(USD) : ',
            value: '\$' + formatCurrency(orderModel.total),
          ),
          30.sh,
          Text('សូមអរគុណសម្រាប់ការអញ្ជើញមក'),
          Sizes.tablePadding.sh,
          Text('Thank You.'),
          15.sh,
          Text('Wifi Password : aklo9999'),
        ],
      ),
    );
  }
}

class TotalTitle extends StatelessWidget {
  const TotalTitle({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: AppStyle.small,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value ?? '',
              style: AppStyle.medium,
            ),
          ),
        ),
      ],
    );
  }
}
