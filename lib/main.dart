import 'package:flutter/material.dart';

void main() {
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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Camp App Home Page'),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  CalendarPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Camp App Calendar Page'),
      ),
    );
  }
}

class PhotoPage extends StatelessWidget {
  PhotoPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Camp App Photo Page'),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Camp App Chat Page'),
      ),
    );
  }
}

class LocatorPage extends StatelessWidget {
  LocatorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Camp App Locator Page'),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Camp App Settings Page'),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      Expanded(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('whusickeriii@satx.rr.com'),
            accountName: Text('Bill Hunsicker'),
            currentAccountPicture: Text('Picture Here'),
          ),
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
            onTap: () => Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new PhotoPage())),
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
