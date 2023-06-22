import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/order/screen/all_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_order_controller.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  final _adminOrderController = Get.put(AdminOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.orders),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(
              text: S.current.all,
            ),
            Tab(
              text: S.current.newOrder,
            ),
            Tab(
              text: S.current.accepted,
            ),
            Tab(
              text: S.current.cancelled,
            ),
            Tab(
              text: S.current.done,
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: TabBarView(
          controller: _tabController,
          children: [
            AllOrder(
              stream: _adminOrderController.allOrderToday,
            ),

            AllOrder(
              stream: _adminOrderController.orderOf(Status.neworder),
            ),

            AllOrder(
              stream: _adminOrderController.orderOf(Status.confirm),
            ),

            AllOrder(
              stream: _adminOrderController.orderOf(Status.cancel),
            ),
            AllOrder(
              stream: _adminOrderController.orderOf(Status.done),
            ),

            // NewOrder(),
            // AcceptedOrder(),
            // CancelledOrder(),
          ],
        ),
      ),
    );
  }
}
