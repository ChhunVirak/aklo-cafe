import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant/resources.dart';

class DrinkCard extends StatelessWidget {
  final String? image;
  final String? name;
  final int? qty;
  final num? unitPrice;
  const DrinkCard({
    super.key,
    this.image,
    this.name,
    this.qty,
    this.unitPrice,
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
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: Sizes.boxRadius,
                image: image != null
                    ? DecorationImage(
                        image: NetworkImage(image!),
                      )
                    : null,
              ),
            ),
          ),
          5.sh,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name ?? '',
                        style: AppStyle.medium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${qty?.toString() ?? '0'} Units',
                        style: AppStyle.small,
                      ),
                    ],
                  ),
                ),
                5.sw,
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
