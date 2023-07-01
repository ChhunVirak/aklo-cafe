import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/about_us/controller/profile_controller.dart';
import 'package:aklo_cafe/module/inventory/components/loading_scaffold.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:aklo_cafe/util/widgets/custom_image_picker_box.dart';
import 'package:aklo_cafe/util/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProfile extends StatefulWidget {
  final String? id;
  const AddProfile({
    super.key,
    this.id,
  });

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  final controller = Get.put(ProfileController());
  static final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  void initState() {
    controller.initialProfileFormForEdit(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    controller.clearForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Profile ID : ${widget.id}');
    return Obx(
      () => controller.loading.value
          ? LoadingScaffold()
          : Scaffold(
              appBar: AppBar(
                title: Text('Add Profile'),
              ),
              body: Form(
                key: _form,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(Sizes.defaultPadding),
                        children: [
                          Center(
                            child: ImagePickerBox(
                              defaultNetWorkImage:
                                  controller.defaultImageNetwork,
                              onSelectImage: (value) {
                                controller.selectedProfile = value;
                              },
                            ),
                          ),
                          CustomTextField(
                            controller: controller.name,
                            label: 'Name',
                            validator: (v) {
                              if (v == '') {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            controller: controller.email,
                            label: 'Email',
                            validator: (v) {
                              if (v == '') {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            controller: controller.department,
                            label: 'Department',
                            validator: (v) {
                              if (v == '') {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            controller: controller.bio,
                            label: 'Bio',
                            validator: (v) {
                              if (v == '') {
                                return 'Required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      minimum: EdgeInsets.all(Sizes.defaultPadding),
                      child: CustomButton(
                        onPressed: () {
                          final isValidated = _form.currentState?.validate();
                          if (isValidated == true) {
                            debugPrint('Validated');

                            if (widget.id == null) {
                              controller.addMember();
                            } else if (widget.id != null) {
                              controller.updateMember(widget.id!);
                            }
                            // Todo : Update Profile
                          }
                        },
                        name: widget.id == null
                            ? S.current.add
                            : S.current.update,
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
