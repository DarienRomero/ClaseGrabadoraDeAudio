import 'package:clase_flutter_demo/body_content.dart';
import 'package:clase_flutter_demo/chat_message_composer.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ClaseFlutterDemo());

class ClaseFlutterDemo extends StatelessWidget{
  const ClaseFlutterDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chat App'),
            ),
            body: const Column(
              children: [
                BodyContent(),
                ChatMessageComposer()
              ],
            )
          );
        }
      ),
    );
  }
}