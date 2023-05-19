import 'dart:io';

import 'package:chatbot_app/constants/app_colors.dart';
import 'package:chatbot_app/constants/app_images.dart';
import 'package:chatbot_app/constants/connectivity_check.dart';
import 'package:chatbot_app/providers/image_provider.dart';
import 'package:chatbot_app/providers/models_provider.dart';
import 'package:chatbot_app/providers/send_message_provider.dart';
import 'package:chatbot_app/screens/theme_screen.dart';
import 'package:chatbot_app/widgets/chat_widget.dart';
import 'package:chatbot_app/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  String question;
  ChatScreen({required this.question, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = widget.question;
    Provider.of<SendMessageProvider>(context,listen: false).clearChat();
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesProvider>(builder: (context, imagesProvider, _) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imagesProvider.imageUrl),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.dstATop),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: imagesProvider.imageList[imagesProvider.index].appBarColor,
            automaticallyImplyLeading: false,
            title: Image.asset(AppImages.aiLogoWhite,height: 100,),
            actions: [
              Consumer<SendMessageProvider>(builder: (context, p, _) {
                return IconButton(
                    onPressed: (){ p.clearChat();p.isAnimateFalse();},
                    icon: const Icon(Icons.delete_outline));
              }),
              IconButton(
                  onPressed: () async {
                    if (await ConnectivityCheck.checkInternet()) {
                      if (mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ThemeScreen(),
                            )).then((value) => focusNode.unfocus());
                      }
                    } else {
                      if (mounted) {
                        Platform.isIOS
                            ? ConnectivityCheck.noInternetDialogIOS(context)
                            : ConnectivityCheck.noInternetDialog(context);
                      }
                    }
                  },
                  icon: const Icon(Icons.color_lens_outlined)),
              IconButton(
                  onPressed: () => openBottomSheet(),
                  icon: const Icon(Icons.more_vert)),
            ],
          ),
          body: Column(
            children: [
              Flexible(
                child: Consumer<SendMessageProvider>(
                    builder: (context, sendMessageProvider, _) {
                  return NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overScroll) {
                      overScroll.disallowIndicator();
                      return false;
                    },
                    child: ListView.builder(
                        controller: sendMessageProvider.scrollController,
                        itemCount: sendMessageProvider.questionsList.length,
                        itemBuilder: (context, i) {
                          return ChatWidget(
                              chatMsg:
                                  sendMessageProvider.questionsList[i].chatMsg,
                              index:
                                  sendMessageProvider.questionsList[i].index);
                        }),
                  );
                }),
              ),
              Consumer<SendMessageProvider>(builder: (context, snapshot, _) {
                return snapshot.isLoadingSendMsg
                    ? const SpinKitThreeBounce(color: AppColors.white, size: 25)
                    : const SizedBox.shrink();
              }),
              const SizedBox(height: 10),
              Card(
                color: imagesProvider
                    .imageList[imagesProvider.index].textFieldColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Consumer2<ModelsProvider, SendMessageProvider>(builder:
                      (context, modelProvider, sendMessageProvider, _) {
                    return Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: textController,
                          focusNode: focusNode,
                          decoration: const InputDecoration.collapsed(
                              hintText: "Hello, How can i help you?"),
                        )),
                        IconButton(
                            onPressed: sendMessageProvider.isAnimate ? null : () async {
                              if (await ConnectivityCheck.checkInternet()) {
                                if (sendMessageProvider.isLoadingSendMsg) {
                                  Fluttertoast.showToast(
                                      msg: "Can't send Multiple questions.");
                                } else {
                                  if (textController.text.trim().isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Can't send empty question.");
                                  } else {
                                    print(
                                        "currentModel ${modelProvider.currentModel}");
                                    // focusNode.unfocus();
                                    sendMessageProvider.addQuestion(
                                        question: textController.text);
                                    if (mounted) {
                                      sendMessageProvider.makeRequest(
                                          modelName: modelProvider.currentModel,
                                          question: textController.text,
                                          context: context);
                                    }
                                    textController.clear();
                                  }
                                }
                              } else {
                                if (mounted) {
                                  Platform.isIOS
                                      ? ConnectivityCheck.noInternetDialogIOS(
                                          context)
                                      : ConnectivityCheck.noInternetDialog(
                                          context);
                                }
                              }
                            },
                            icon: const Icon(Icons.send_outlined))
                      ],
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Future openBottomSheet() async {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Chosen model: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ModelDropDown()
              ],
            ),
          );
        });
  }
}
