import 'package:aklo_cafe/generated/l10n.dart';
import 'package:aklo_cafe/module/auth/controller/user_setting_controller.dart';
import 'package:aklo_cafe/module/inventory/components/loading_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSetting extends StatefulWidget {
  final String? userId;
  const UserSetting({
    super.key,
    required this.userId,
  });

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  final _controller = Get.put(UserSettingController());

  @override
  void initState() {
    _controller.getUserSetting(widget.userId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.loading.value
          ? LoadingScaffold()
          : Scaffold(
              appBar: AppBar(
                title: Text(_controller.userModel.value.username ?? 'ss'),
              ),
              body: Column(
                children: [
                  ListTile(
                    title: Text(S.current.addDrink),
                    trailing: Switch(
                      value: _controller.userModel.value.addProduct == true,
                      onChanged: (value) async {
                        await _controller.updatePermission(widget.userId!, {
                          'addProduct': value,
                        });
                        _controller.userModel.value.addProduct = value;
                        _controller.userModel.refresh();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(S.current.addCategory),
                    trailing: Switch(
                      value: _controller.userModel.value.addCategory == true,
                      onChanged: (value) async {
                        await _controller.updatePermission(widget.userId!, {
                          'addCategory': value,
                        });
                        _controller.userModel.value.addCategory = value;
                        _controller.userModel.refresh();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Delete Drink'),
                    trailing: Switch(
                      value: _controller.userModel.value.deleteProduct == true,
                      onChanged: (value) async {
                        await _controller.updatePermission(widget.userId!, {
                          'deleteProduct': value,
                        });
                        _controller.userModel.value.deleteProduct = value;
                        _controller.userModel.refresh();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Delete Category'),
                    trailing: Switch(
                      value: _controller.userModel.value.deleteCategory == true,
                      onChanged: (value) async {
                        await _controller.updatePermission(widget.userId!, {
                          'deleteCategory': value,
                        });
                        _controller.userModel.value.deleteCategory = value;
                        _controller.userModel.refresh();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Edit Drink'),
                    trailing: Switch(
                      value: _controller.userModel.value.updateProduct == true,
                      onChanged: (value) async {
                        await _controller.updatePermission(widget.userId!, {
                          'updateProduct': value,
                        });
                        _controller.userModel.value.updateProduct = value;
                        _controller.userModel.refresh();
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Edit Category'),
                    trailing: Switch(
                      value: _controller.userModel.value.updateCategory == true,
                      onChanged: (value) async {
                        await _controller.updatePermission(widget.userId!, {
                          'updateCategory': value,
                        });
                        _controller.userModel.value.updateCategory = value;
                        _controller.userModel.refresh();
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
