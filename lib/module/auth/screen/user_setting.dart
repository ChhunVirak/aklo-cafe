import 'package:aklo_cafe/generated/l10n.dart';
import 'package:flutter/material.dart';

class UserSetting extends StatelessWidget {
  const UserSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kihong'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(S.current.addDrink),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text(S.current.addCategory),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text('Delete Drink'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text('Delete Category'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text('Edit Drink'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: Text('Edit Category'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
