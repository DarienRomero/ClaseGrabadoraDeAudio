import 'package:clase_flutter_demo/utils.dart';
import 'package:flutter/material.dart';

class RecordingIndicator extends StatelessWidget {
  const RecordingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mqWidth(context, 4),
      height: mqWidth(context, 4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red
      ),
    );
  }
}