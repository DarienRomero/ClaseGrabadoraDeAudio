import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyContent extends StatefulWidget {
  const BodyContent({super.key});

  @override
  State<BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  double opacidad = 0.0;
  double width = 100;
  double height = 100;
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          
        ],
      )
    );
  }
}