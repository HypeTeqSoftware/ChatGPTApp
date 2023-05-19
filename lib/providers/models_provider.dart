import 'package:chatbot_app/api_services/api_call.dart';
import 'package:chatbot_app/models/models_model.dart';
import 'package:flutter/cupertino.dart';

class ModelsProvider with ChangeNotifier {
  List<Data> jsonResponseList = [];
  String currentModel = "text-davinci-003";

  setCurrentModel(String model) {
    currentModel = model;
    notifyListeners();
  }

  Future<List<Data>> getModels(context) async {
    jsonResponseList = await APICall.getModels(context);
    return jsonResponseList;
  }
}
