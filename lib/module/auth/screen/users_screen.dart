import 'package:aklo_cafe/constant/colors.dart';
import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/widgets/app_circular_loading.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: StreamBuilder(
        stream: controller.userdb.snapshots(),
        builder: (_, snapshot) {
          final data = snapshot.data?.docs;
          debugPrint('Data ${snapshot.data?.docs}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CustomCircularLoading(),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return ListView.separated(
              itemCount: data?.length ?? 0,
              separatorBuilder: (_, __) => 5.sh,
              itemBuilder: (_, index) => ListTile(
                title: Text(data?[index]['name'].toString() ?? ''),
                subtitle: Text(data?[index]['role'].toString() ?? ''),
                onTap: () {},
                tileColor: AppColors.backgroundColor,
              ),
            );
          }
          return const Text('Error');
        },
      ),
    );
  }
}