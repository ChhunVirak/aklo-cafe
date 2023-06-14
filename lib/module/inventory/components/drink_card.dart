import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl/intl.dart';

import '../../../constant/resources.dart';

class DrinkCard extends StatelessWidget {
  final String? image;
  final String? name;
  final int? qty;
  final num? unitPrice;
  final int? amount;
  final GestureTapCallback? onPressedAdd;
  final GestureTapCallback? onPressedRemove;
  const DrinkCard({
    super.key,
    this.image,
    this.name,
    this.qty,
    this.unitPrice,
    this.onPressedAdd,
    this.onPressedRemove,
    this.amount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: Sizes.boxBorderRadius,
                    image: image != null
                        ? DecorationImage(
                            image: NetworkImage(image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: image == null ? const Text('No Image') : null,
                ),
                if (onPressedAdd != null)
                  Card(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (amount != null && amount! > 0)
                          IconButton(
                            onPressed: () {
                              onPressedRemove?.call();
                            },
                            icon: const Icon(
                              PhosphorIcons.minus_circle_fill,
                            ),
                          ),
                        if (amount != null && amount! > 0)
                          Container(
                            child: Text(amount.toString()),
                          ),
                        IconButton(
                          onPressed: () {
                            onPressedAdd?.call();
                          },
                          icon: const Icon(
                            PhosphorIcons.plus_circle_fill,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
          5.sh,
          Text(
            name ?? '',
            style: AppStyle.medium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (qty != null)
                  Expanded(
                    child: Text(
                      '${qty?.toString() ?? '0'} Units',
                      style: AppStyle.small,
                    ),
                  ),
                5.sw,
                if (unitPrice != null)
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: NumberFormat('#.00').format(unitPrice),
                          style: AppStyle.large.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.top,
                          child: Text(
                            '\$',
                            style: AppStyle.large.copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
