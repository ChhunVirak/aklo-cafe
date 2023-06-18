import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/order/screen/accepted_order.dart';
import 'package:aklo_cafe/module/order/screen/all_orders.dart';
import 'package:aklo_cafe/module/order/screen/cancelled_order.dart';
import 'package:aklo_cafe/module/order/screen/new_order.dart';
import 'package:flutter/material.dart';

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
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

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
          ],
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: TabBarView(
          controller: _tabController,
          children: [
            AllOrder(),
            NewOrder(),
            AcceptedOrder(),
            CancelledOrder(),
          ],
        ),
      ),
    );
  }
}
