import 'package:chatbot_app/api_services/api_call.dart';
import 'package:chatbot_app/models/chat_model.dart';
import 'package:flutter/material.dart';

class SendMessageProvider with ChangeNotifier {
  bool isLoadingSendMsg = false,isAnimate = false;
  List<ChatModel> questionsList = [];
  final scrollController = ScrollController();

  addQuestion({required String question}){
    questionsList.add(ChatModel(chatMsg: question, index: 0));
    notifyListeners();
  }

  Future<void> makeRequest(
      {required String modelName, required String question,required BuildContext context}) async {
    isLoadingSendMsg = true;
    notifyListeners();
    questionsList.addAll(await APICall.makeRequest(modelName: modelName, question: question,context: context));
    scrollAutomatic();
    isLoadingSendMsg = false;
    isAnimate = true;
    notifyListeners();
  }

  scrollAutomatic(){
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(seconds: 2), curve: Curves.easeOut);
    notifyListeners();
  }

  clearChat(){
    questionsList.clear();
    // notifyListeners();
  }

  isAnimateTrue(){
    isAnimate = true;
    notifyListeners();
  }
  isAnimateFalse(){
    isAnimate = false;
    notifyListeners();
  }

}
