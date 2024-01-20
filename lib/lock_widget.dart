import 'package:clase_flutter_demo/recording_state.dart';
import 'package:clase_flutter_demo/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LockWidget extends StatelessWidget {
  final RecordingState recordingState;

  const LockWidget({super.key, 
    required this.recordingState
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mqWidth(context, 8),
      height: mqWidth(context, recordingState.isBlocked  ? 10 : 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).primaryColor.withOpacity(0.4)
      ),
      child: Center(
        child: recordingState.isBlocked ? 
          SvgPicture.asset("assets/icons/vuesax-bold-stop.svg") :
          SvgPicture.asset("assets/icons/lock_micro_icon.svg"),
      ),
    );
  }
}