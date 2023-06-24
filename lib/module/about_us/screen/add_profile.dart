import 'package:aklo_cafe/constant/resources.dart';
import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/about_us/controller/profile_controller.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:aklo_cafe/util/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProfile extends StatelessWidget {
  const AddProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Profile'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(Sizes.defaultPadding),
              children: [
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
              onPressed: () {},
              name: S.current.add,
            ),
          )
        ],
      ),
    );
  }
}
