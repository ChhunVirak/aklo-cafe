import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant/resources.dart';

class ClientDrinkCard extends StatelessWidget {
  final String? image;
  final String? name;
  final bool? available;
  final num? unitPrice;
  final int? amount;
  final GestureTapCallback? onPressedAdd;
  final GestureTapCallback? onPressedRemove;
  const ClientDrinkCard({
    super.key,
    this.image,
    this.name,
    // this.qty,
    this.unitPrice,
    this.onPressedAdd,
    this.onPressedRemove,
    this.amount = 0,
    this.available,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('Available $available');
    return Container(
      padding: EdgeInsets.only(
        top: Sizes.textPadding,
        left: Sizes.textPadding,
        right: Sizes.textPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.txtLightColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0.1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.deepBackgroundColor,
                    borderRadius: Sizes.boxBorderRadius,
                    image: image != null
                        ? DecorationImage(
                            image: NetworkImage(image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: image == null ? Text(S.current.noImage) : null,
                ),
              ),
              if (available == false)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  width: double.infinity,
                  color: Colors.black38,
                  alignment: Alignment.center,
                  child: Text(
                    S.current.unAvailable,
                    style: AppStyle.medium
                        .copyWith(color: AppColors.txtLightColor),
                  ),
                )
            ],
          ),
          5.sh,
          Text(
            name ?? '',
            style: AppStyle.medium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (unitPrice != null)
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: NumberFormat('#.00', 'en').format(unitPrice),
                            style: AppStyle.large.copyWith(
                              fontSize: 18,
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
                  ),
                if (available == true)
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.deepBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (amount != null && amount! > 0)
                          GestureDetector(
                            onTap: () {
                              onPressedRemove?.call();
                            },
                            child: Container(
                              color: Colors.red,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.remove_rounded,
                                color: AppColors.txtLightColor,
                                size: 20,
                              ),
                            ),
                          ),
                        if (amount != null && amount! > 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Text(amount.toString()),
                          ),
                        GestureDetector(
                          onTap: () {
                            onPressedAdd?.call();
                          },
                          child: Container(
                            color: Colors.green,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.add_rounded,
                              size: 20,
                              color: AppColors.txtLightColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                5.sw,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
