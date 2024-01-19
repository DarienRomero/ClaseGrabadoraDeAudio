import 'package:clase_flutter_demo/recording_state.dart';
import 'package:clase_flutter_demo/send_or_message_icon.dart';
import 'package:clase_flutter_demo/utils.dart';
import 'package:flutter/material.dart';

class ChatMessageComposer extends StatefulWidget {
  const ChatMessageComposer({super.key});

  @override
  State<ChatMessageComposer> createState() => _ChatMessageComposerState();
}

class _ChatMessageComposerState extends State<ChatMessageComposer> {
  RecordingState recordingState = RecordingState.free;
  Offset _dragOffset = Offset.zero;
  Offset _dragOffsetInitial = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: mqWidth(context, 100),
          height: mqHeigth(context, 12),
          padding: EdgeInsets.symmetric(
            horizontal: mqWidth(context, 2.5),
            vertical: mqHeigth(context, 2)
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffEBF0F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: mqWidth(context, 83),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Mensaje",
                      hintStyle:  const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff999daf),
                        fontSize: 12,
                        height: 1.7
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: mqWidth(context, 5)
                      )
                    ),
                  )
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: recordingState.isRecording ? 0 : (mqHeigth(context, 12) - mqWidth(context, 10)) / 2,
          right: recordingState.isRecording ? 0 : mqWidth(context, 4.5),
          child: GestureDetector(
            onTap: (){
              if(recordingState.isBlocked){
                print("Finalizamos la grabación y se envía");
                recordingState = RecordingState.free;
                setState(() {});
                return;
              }
              const snackBar = SnackBar(
                content: Text("Mantén presionado para grabar, suelta para enviar"),
                duration: Duration(milliseconds: 500),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: LongPressDraggable(
              feedback: Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
              onDragStarted: () async {
                print("Iniciamos grabación");
                recordingState = RecordingState.recording;
                setState(() {});
              },
              onDragEnd: (_){
                print("Finalizamos la grabación y se envía");
                if(recordingState == RecordingState.recording){
                  recordingState = RecordingState.free;
                  setState(() {});
                }
              },
              onDragUpdate: (details){
                print(details.localPosition.dy);
                if(details.localPosition.dy < 500){
                  print("Bloqueamos al estado de grabando, ya se puede soltar");
                  recordingState = RecordingState.blocked;
                  setState(() {});
                  return;
                }
              },
              child: SendOrMessageIcon(recordingState: recordingState)
            ),
          )
        )
      ],
    );
  }
}