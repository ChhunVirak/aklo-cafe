import 'package:aklo_cafe/config/router/app_pages.dart';
import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/about_us/controller/profile_controller.dart';
import 'package:aklo_cafe/util/alerts/app_dialog.dart';
import 'package:aklo_cafe/util/alerts/app_modal_bottomsheet.dart';
import 'package:aklo_cafe/util/alerts/app_snackbar.dart';
import 'package:aklo_cafe/util/extensions/object_validation_extension.dart';
import 'package:aklo_cafe/util/extensions/widget_extension.dart';
import 'package:aklo_cafe/util/widgets/app_circular_loading.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.about_us),
      ),
      body: StreamBuilder(
        stream: controller.streamProfiles,
        builder: (_, snapshot) {
          final profiles = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CustomCircularLoading(),
            );
          }
          if (!snapshot.hasData ||
              (snapshot.hasData && profiles.notNull && profiles!.length <= 0)) {
            return Center(
              child: Text(S.current.no_data),
            );
          }
          if (snapshot.hasData && profiles != null) {
            return GridView.builder(
              padding: EdgeInsets.all(Sizes.defaultPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: Sizes.defaultPadding,
                crossAxisSpacing: Sizes.defaultPadding,
              ),
              itemCount: profiles.length,
              itemBuilder: (_, index) {
                final profile = profiles[index];
                return GestureDetector(
                  onTap: () {
                    pushSubRoute('profile/${profiles[index].id}');
                  },
                  onLongPress: () {
                    showCustomModalBottomSheet(
                      Container(
                        padding: const EdgeInsets.all(Sizes.defaultPadding),
                        // color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButton(
                              onPressed: () {
                                //remove pop up
                                Get.back();

                                pushSubRoute(
                                  Routes.ADD_MEMBER,
                                  queryParams: {"id": profile.id},
                                );
                              },
                              name: S.current.edit,
                            ),
                            Sizes.defaultPadding.sh,
                            CustomButton(
                              onPressed: () {
                                showCustomDialog(
                                  title: 'Confirm!',
                                  description:
                                      'Are you sure want to delete ${profile.name}',
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        //TODO : add delete function
                                        controller.deleteProfile(
                                            profile.id!, profile.image);
                                        Get.back();
                                        Get.back();
                                        showErrorSnackBar(
                                            title: S.current.success,
                                            description:
                                                S.current.delete_success);
                                      },
                                      child: Text(S.current.yes),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(S.current.cancel),
                                    ),
                                  ],
                                );
                              },
                              backgroundColor: Colors.red,
                              name: S.current.delete,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      !profiles[index].image.isValid
                          ? Container(
                              decoration: BoxDecoration(
                                  color: AppColors.backgroundColor),
                              child: Center(child: Text(S.current.noImage)),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: AppColors.deepBackgroundColor,
                                image: DecorationImage(
                                  image: NetworkImage(profiles[index].image!),
                                ),
                              ),
                            ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black87,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          profiles[index].name,
                          style: AppStyle.small.copyWith(
                            color: AppColors.txtLightColor,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushSubRoute(Routes.ADD_MEMBER);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
