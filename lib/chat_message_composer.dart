import 'package:clase_flutter_demo/h_spacing.dart';
import 'package:clase_flutter_demo/lock_widget.dart';
import 'package:clase_flutter_demo/recording_indicator.dart';
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
  String _recorderTxt = "0:00"; 

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        //Caja de texto
        Container(
          width: mqWidth(context, 100),
          height: mqHeigth(context, 12),
          padding: EdgeInsets.symmetric(
            horizontal: mqWidth(context, 2.5),
            vertical: mqHeigth(context, 2)
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), 
                ),
              ]
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
        //Componente de Cancelar
        AnimatedOpacity(
          opacity: recordingState.isRecording ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: recordingState.isRecording ? Container(
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
              padding: EdgeInsets.symmetric(
                horizontal: mqWidth(context, 3)
              ),
              child: Row(
                children: [
                  const RecordingIndicator(),
                  const HSpacing(3),
                  Text(_recorderTxt, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).disabledColor.withOpacity(0.4)
                  )),
                  const HSpacing(3),
                  recordingState.isBlocked ? TextButton(
                    onPressed: (){
                      print("Finalizamos la grabación y se envía");
                      recordingState = RecordingState.free;
                      setState(() {});
                      return;
                    },
                    child: const Text("Cancelar", style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
                  ) : const Text("Desliza para cancelar", style: TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
            )
          ) : Container(),
        ),
        //Componente de candado
        Builder(
          builder: (context) {
            final diff = _dragOffsetInitial.dy - _dragOffset.dy;
            return AnimatedPositioned(
              duration: Duration(milliseconds: recordingState.isBlocked ? 100 : 300),
              right: mqWidth(context, 6),
              top: recordingState.isBlocked ? mqHeigth(context, - 8 ) : mqHeigth(context, recordingState.isRecording ? -12 : 4) - (recordingState.isRecording ? diff / 2 : 0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: recordingState.isRecording ? 1.0 : 0.0,
                child: LockWidget(recordingState: recordingState)
              )
            );
          }
        ),
        //Enviar mensaje o audio
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
              feedback: Container(),
              /* feedback: Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ), */
              onDragStarted: () async {
                print("Iniciamos grabación");
                recordingState = RecordingState.recording;
                setState(() {});
              },
              onDragEnd: (_){
                _dragOffsetInitial = Offset.zero;
                _dragOffset = Offset.zero;
                print("Finalizamos la grabación y se envía");
                if(recordingState == RecordingState.recording){
                  recordingState = RecordingState.free;
                }
                setState(() {});
              },
              onDragUpdate: (details){
                print(details.localPosition.dx);
                _dragOffset = details.localPosition;
                if(_dragOffsetInitial.dy == 0){
                  _dragOffsetInitial = _dragOffset;
                }
                if(details.localPosition.dy < 500){
                  print("Bloqueamos al estado de grabando, ya se puede soltar");
                  recordingState = RecordingState.blocked;
                }
                if(details.localPosition.dx < 200){
                  print("Finalizamos la grabación pero no se envía");
                  recordingState = RecordingState.free;
                }
                setState(() {});
              },
              child: SendOrMessageIcon(recordingState: recordingState)
            ),
          )
        )
      ],
    );
  }
}