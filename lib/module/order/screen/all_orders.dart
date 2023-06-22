// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aklo_cafe/module/order/controller/admin_order_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:aklo_cafe/config/router/app_pages.dart';
import 'package:aklo_cafe/module/client/model/order_model.dart';
import 'package:aklo_cafe/util/extensions/datetime_extension.dart';
import 'package:aklo_cafe/util/function/format_function.dart';
import 'package:aklo_cafe/util/widgets/app_circular_loading.dart';

import '../../../constant/resources.dart';
import '../../../generated/l10n.dart';

class AllOrder extends StatelessWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  const AllOrder({
    Key? key,
    required this.stream,
  }) : super(key: key);

  Color? statusByColor(String? status) {
    switch (status) {
      case Status.neworder:
        return Colors.grey;
      case Status.confirm:
        return Colors.yellow;
      case Status.cancel:
        return Colors.red;
      case Status.done:
        return Colors.green;
      default:
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CustomCircularLoading(),
          );

        if (snapshot.hasData) {
          debugPrint('Work Here ${snapshot.data?.docs.isEmpty}');
          if (snapshot.data?.docs.isEmpty == true)
            return Center(
              child: Text(S.current.no_data),
            );
          if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
            final listOrderData = snapshot.data!.docs
                .map(
                  (e) => OrderModel.fromMap(
                    e.data(),
                  ),
                )
                .toList();
            return ListView.separated(
              padding:
                  const EdgeInsets.symmetric(vertical: Sizes.defaultPadding),
              itemCount: listOrderData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.only(right: Sizes.defaultPadding),
                  dense: true,

                  leading: Container(
                    width: 5,
                    color: statusByColor(listOrderData[index].status),
                  ),
                  onTap: () {
                    pushSubRoute(listOrderData[index].id ?? '');
                  },
                  subtitle:
                      Text(listOrderData[index].orderDate.displayDateTime),
                  title: Text(
                    '#' + NumberFormat('000').format(index + 1).toString(),
                  ),
                  // title: Text(listOrderData[index].id?.toUpperCase() ?? ''),
                  trailing: Text(
                    '\$' + formatCurrency(listOrderData[index].total),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(
                height: 0,
                color: AppColors.deepBackgroundColor,
                // height: 0,
              ),
            );
          }
        }
        return Text('Something went wrong');
      },
    );
  }
}
