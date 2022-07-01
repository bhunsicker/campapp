import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Camp App Settings Page'),
      ),
      body: SimpleSettingsTile(
        title: 'Account Settings',
        child: SettingsScreen(
          title: 'Sub menu',
          children: <Widget>[
            TextInputSettingsTile(
              title: 'Account Email',
              settingKey: 'accountEmail',
              initialValue: 'first.last@server.com',
              borderColor: Colors.blueAccent,
              errorColor: Colors.deepOrangeAccent,
            ),
            TextInputSettingsTile(
              title: 'Account Name',
              settingKey: 'accountName',
              initialValue: 'First Last',
              borderColor: Colors.blueAccent,
              errorColor: Colors.deepOrangeAccent,
            ),
            TextInputSettingsTile(
              title: 'Account Picture',
              settingKey: 'accountPicture',
              initialValue: 'Picture Here',
              borderColor: Colors.blueAccent,
              errorColor: Colors.deepOrangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
