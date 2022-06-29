import 'package:flutter/material.dart';
import 'main.dart';

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
