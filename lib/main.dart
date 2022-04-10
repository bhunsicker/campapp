//import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camp App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Camp App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget appDrawer(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: const [
        UserAccountsDrawerHeader(
          accountEmail: Text('whusickeriii@satx.rr.com'),
          accountName: Text('Bill Hunsicker'),
          currentAccountPicture: Text('Picture Here'),
        ),
        ListTile(leading: Icon(Icons.calendar_month), title: Text('Calendar'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwo(),)) ,
        ListTile(
            leading: Icon(Icons.photo_album), title: Text('Upload Pictures')),
        ListTile(leading: Icon(Icons.chat_bubble), title: Text('Chat')),
        ListTile(leading: Icon(Icons.location_pin), title: Text('Locator')),
      ]),
    );
  }

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Burger Time!'),
      ),
      body: Center(
        child: Text('Page TWO /flex'),
      ),
      drawer: MyDrawerDirectory(), // ← Drawer Directory a.k.a. burger icon
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: appDrawer(context),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
      ),
    );
  }
}
