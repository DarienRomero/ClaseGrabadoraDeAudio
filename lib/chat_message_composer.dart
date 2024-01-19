import 'package:clase_flutter_demo/utils.dart';
import 'package:flutter/material.dart';

class ChatMessageComposer extends StatelessWidget {
  const ChatMessageComposer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
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
      ],
    );
  }
}