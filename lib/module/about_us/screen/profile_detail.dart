import 'package:aklo_cafe/config/router/app_pages.dart';
import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/about_us/controller/profile_controller.dart';
import 'package:aklo_cafe/util/extensions/object_validation_extension.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/widgets/app_circular_loading.dart';

class ProfileDetail extends StatelessWidget {
  final String? id;
  const ProfileDetail({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.about_us),
      ),
      body: StreamBuilder(
        stream: id != null ? controller.streamProfile(id!) : null,
        builder: (_, snapshot) {
          final profile = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CustomCircularLoading(),
            );
          }
          if (!snapshot.hasData || (snapshot.hasData && profile.isNuull)) {
            return Center(
              child: Text(S.current.no_data),
            );
          }
          if (profile.notNull) {
            return Container(
              width: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: Sizes.defaultPadding,
                  right: Sizes.defaultPadding,
                  top: Sizes.defaultPadding,
                  bottom: 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: context.width * .3,
                      backgroundColor: AppColors.deepBackgroundColor,
                      backgroundImage: profile.notNull && profile!.image.isValid
                          ? NetworkImage(
                              profile.image!,
                            )
                          : null,
                    ),
                    10.sh,
                    NameBox(des: 'Name', name: profile?.name),
                    5.sh,
                    NameBox(des: 'Email', name: profile?.email),
                    5.sh,
                    NameBox(des: 'Department', name: profile?.department),
                    5.sh,
                    NameBox(des: 'Bio', name: profile?.bio),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushSubRoute(
            Routes.ADD_MEMBER,
            queryParams: {'id': id},
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class NameBox extends StatelessWidget {
  const NameBox({
    super.key,
    required this.des,
    required this.name,
  });

  final String des;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                des,
                style: AppStyle.small.copyWith(fontSize: 12),
              ),
              Text(
                name ?? '',
                style: AppStyle.medium
                    .copyWith(fontSize: 14, color: AppColors.mainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
