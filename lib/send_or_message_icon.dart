import 'package:clase_flutter_demo/recording_state.dart';
import 'package:clase_flutter_demo/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendOrMessageIcon extends StatelessWidget {
  final RecordingState recordingState;
  const SendOrMessageIcon({
    super.key,
    required this.recordingState
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: recordingState.isRecording ? mqHeigth(context, 12) : mqWidth(context, 10),
      height: recordingState.isRecording ? mqHeigth(context, 12) : mqWidth(context, 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(recordingState.isRecording ? 30 : 15)
      ),
      child: Center(
        child: recordingState.isBlocked ?
        SvgPicture.asset(
          'assets/icons/send_icon.svg',
          color: Colors.white,
          width: mqWidth(context, recordingState.isRecording ? 10 : 6),
        ) :
        SvgPicture.asset(
          'assets/icons/microphone_icon.svg',
          color: Colors.white,
          width: mqWidth(context, recordingState.isRecording ? 10 : 6),
        )
      ),
    );
  }
}