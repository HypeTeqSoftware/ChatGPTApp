import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatbot_app/constants/app_colors.dart';
import 'package:chatbot_app/constants/app_images.dart';
import 'package:chatbot_app/providers/image_provider.dart';
import 'package:chatbot_app/providers/send_message_provider.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class ChatWidget extends StatelessWidget {
  String chatMsg;
  int index;
  ChatWidget({required this.chatMsg, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<ImagesProvider>(
          builder: (context, snapshot,_) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Flexible(
                          child: Row(
                        mainAxisAlignment: index == 0
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Image.asset(
                                    AppImages.robot,
                                    height: 40,
                                  ),
                                ),
                          index == 0
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: CustomPaint(
                                      painter: CustomShape(snapshot.imageList[snapshot.index].receiverBubbleColor),
                                    ),
                                  ),
                                ),
                          Flexible(
                            child: Padding(
                              padding: index == 0
                                  ? const EdgeInsets.only(top: 0.0)
                                  : const EdgeInsets.only(top: 15.0),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: index == 0
                                      ? snapshot.imageList[snapshot.index].senderBubbleColor
                                      : snapshot.imageList[snapshot.index].receiverBubbleColor,
                                  borderRadius: index == 0
                                      ? const BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          bottomLeft: Radius.circular(18),
                                          bottomRight: Radius.circular(18),
                                        )
                                      : const BorderRadius.only(
                                          topRight: Radius.circular(18),
                                          bottomLeft: Radius.circular(18),
                                          bottomRight: Radius.circular(18),
                                        ),
                                ),
                                child: index == 0
                                    ? Text(
                                        chatMsg,
                                        style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Consumer<SendMessageProvider>(
                                            builder: (context, snapshot,_) {
                                              return AnimatedTextKit(
                                                  isRepeatingAnimation: false,
                                                  repeatForever: false,
                                                  onTap: (){
                                                    snapshot.isAnimateFalse();
                                                  },
                                                  onFinished: (){
                                                    snapshot.isAnimateFalse();
                                                  },
                                                  displayFullTextOnTap: true,
                                                  totalRepeatCount: 1,
                                                  animatedTexts: [
                                                    TyperAnimatedText(chatMsg.trim()),
                                                  ]);
                                            }
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              Icon(Icons.thumb_up_alt_outlined),
                                              SizedBox(width: 10),
                                              Icon(Icons.thumb_down_alt_outlined),
                                            ],
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          index == 0
                              ? CustomPaint(painter: CustomShape(snapshot.imageList[snapshot.index].senderBubbleColor))
                              : const SizedBox.shrink(),
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            );
          }
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     color: index == 0 ? AppColors.black : Colors.white24,
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         children: [
        //           Row(
        //             mainAxisAlignment: index == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               index == 0
        //                   ? const Icon(Icons.question_mark_outlined, size: 35)
        //                   : Image.asset(
        //                       AppImages.robot,
        //                       height: 35,
        //                     ),
        //
        //               index == 0 ?  Flexible(
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.end,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                    Flexible(
        //                         child: Container(
        //                           padding: EdgeInsets.all(14),
        //                           decoration: BoxDecoration(
        //                             color: Colors.cyan[900],
        //                             borderRadius: BorderRadius.only(
        //                               topLeft: Radius.circular(18),
        //                               bottomLeft: Radius.circular(18),
        //                               bottomRight: Radius.circular(18),
        //                             ),
        //                           ),
        //                           child: Text(
        //                             chatMsg,
        //                             style: TextStyle(color: Colors.white, fontSize: 14),
        //                           ),
        //                         ),
        //                       ),
        //                       CustomPaint(painter: CustomShape(Colors.cyan[900]!)),
        //                     ],
        //                   )) : Flexible(
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Transform(
        //                         alignment: Alignment.center,
        //                         transform: Matrix4.rotationY(math.pi),
        //                         child: CustomPaint(
        //                           painter: CustomShape(Colors.grey[300]!),
        //                         ),
        //                       ),
        //                       Flexible(
        //                         child: Container(
        //                           padding: EdgeInsets.all(14),
        //                           decoration: BoxDecoration(
        //                             color: Colors.grey[300],
        //                             borderRadius: BorderRadius.only(
        //                               topRight: Radius.circular(18),
        //                               bottomLeft: Radius.circular(18),
        //                               bottomRight: Radius.circular(18),
        //                             ),
        //                           ),
        //                           child: Text(
        //                             chatMsg,
        //                             style: TextStyle(color: Colors.black, fontSize: 14),
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ))
        //               // Flexible(
        //               //     child: Padding(
        //               //   padding: const EdgeInsets.all(8.0),
        //               //   child: index == 0 ? Text(chatMsg) : AnimatedTextKit(
        //               //       isRepeatingAnimation: false,repeatForever: false,displayFullTextOnTap: true,totalRepeatCount: 1,
        //               //       animatedTexts: [TyperAnimatedText(chatMsg.trim())]),
        //               // )),
        //             ],
        //           ),
        //           index == 0
        //               ? const SizedBox.shrink()
        //               : Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   children: const [
        //                     Icon(Icons.thumb_up_alt_outlined),
        //                     SizedBox(width: 10),
        //                     Icon(Icons.thumb_down_alt_outlined),
        //                   ],
        //                 )
        //         ],
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}

class CustomShape extends CustomPainter {
  final Color bgColor;

  CustomShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
