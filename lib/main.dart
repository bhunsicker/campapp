import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'calendarpage.dart';
import 'homepage.dart';
import 'photopage.dart';
import 'chatpage.dart';
import 'locatorpage.dart';
import 'settingspage.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

// 220035809284-jr3l135tnvsedi27rab9rcmvdmt8uuud.apps.googleusercontent.com

Future<void> main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(CampApp());
}

class CampApp extends StatelessWidget {
  CampApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camp App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PermissionState permitted;
    return Drawer(
        child: Column(children: <Widget>[
      Expanded(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          // UserAccountsDrawerHeader(
          //   accountEmail:
          //       Settings.getValue("accountEmail", defaultValue: Text('Email')),
          //   accountName:
          //       Settings.getValue("accountName", defaultValue: Text('Name')),
          //   currentAccountPicture: Settings.getValue("accountPicture",
          //       defaultValue: Text('Picture')),
          // ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Calendar'),
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new CalendarPage())),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Upload Pictures'),
            onTap: () async => {
              // permitted = await PhotoManager.requestPermissionExtend();
              // if (!permitted.isAuth) return;
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => new PhotoPage())),
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text('Chat'),
            onTap: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new ChatPage())),
          ),
          ListTile(
            leading: Icon(Icons.location_pin),
            title: Text('Locator'),
            onTap: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new LocatorPage())),
          )
        ]),
      ),
      Container(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  child: Column(
                children: <Widget>[
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new SettingsPage())),
                  ),
                ],
              ))))
    ]));
  }
}
