import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../util/widgets/app_circular_loading.dart';
import 'add_user.dart';
import 'user_setting.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Scaffold(
      floatingActionButton: Obx(
        () => controller.isAdmin.value
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => AddUserScreen());
                },
                child: const Icon(Icons.add),
              )
            : SizedBox.shrink(),
      ),
      appBar: AppBar(
        title: Text(S.current.users),
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
          if (snapshot.hasData) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Sizes.defaultPadding),
              itemCount: data?.length ?? 0,
              separatorBuilder: (_, __) => 10.sh,
              itemBuilder: (_, index) {
                final user = data?[index].data();
                return ListTile(
                  leading: Icon(PhosphorIcons.user_bold),
                  title: Text(user?['username'] ?? '--'),
                  subtitle: Text(user?['role'] ?? '--'),
                  onTap: () {
                    Get.to(() => UserSetting());
                  },
                  tileColor: AppColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: Sizes.boxBorderRadius),
                  trailing: controller.userId == user?['id']
                      ? Icon(
                          PhosphorIcons.globe_hemisphere_east,
                          color: Colors.green,
                        )
                      : null,
                );
              },
            );
          }
          return const Text('Error');
        },
      ),
    );
  }
}
