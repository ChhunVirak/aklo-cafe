import 'package:aklo_cafe/module/auth/controller/auth_controller.dart';
import 'package:aklo_cafe/util/widgets/custom_button.dart';
import 'package:aklo_cafe/util/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final controller = Get.put(AuthController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: username,
                        label: 'Username',
                        prefixIcon: Icon(PhosphorIcons.user_bold),
                        validator: (v) =>
                            v == '' ? S.current.userNameValidateMessage : null,
                      ),
                      CustomTextField(
                        controller: email,
                        label: 'Email',
                        prefixIcon: Icon(PhosphorIcons.at_bold),
                        validator: (v) =>
                            v == '' ? S.current.emailValidateMessage : null,
                      ),
                      CustomTextField(
                        controller: password,
                        label: 'Password',
                        prefixIcon: Icon(PhosphorIcons.password_bold),
                        validator: (v) =>
                            v == '' ? S.current.passwordValidateMessage : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(
              onPressed: () async {
                final validated = _formKey.currentState?.validate();

                if (validated == true) {
                  await controller.createUser(
                      username: username.text,
                      email: email.text,
                      password: password.text);
                }
              },
              name: 'Create',
            )
          ],
        ),
      ),
    );
  }
}
