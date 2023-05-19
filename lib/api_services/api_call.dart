import 'dart:convert';
import 'dart:io';

import 'package:chatbot_app/constants/api_constants.dart';
import 'package:chatbot_app/constants/app_colors.dart';
import 'package:chatbot_app/constants/connectivity_check.dart';
import 'package:chatbot_app/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/models_model.dart';

class APICall {
  static Models jsonResponseModel = Models();
  static List<Data> jsonResponseModelList = [];

  static Future<List<Data>> getModels(context) async {
    try {
      if(await ConnectivityCheck.checkInternet()){
        var response = await http.get(Uri.parse(baseUrl + models),
            headers: {'Authorization': 'Bearer $apiKey'});
        jsonResponseModel = Models.fromJson(jsonDecode(response.body));
        if (jsonResponseModel.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Something Went Wrong",
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
              backgroundColor: AppColors.red,
              behavior: SnackBarBehavior.floating, margin: EdgeInsets.fromLTRB(0, 0, 0, 200)
          ));
          throw HttpException(jsonResponseModel.error!.message!);
        }
        jsonResponseModelList = jsonResponseModel.data!;
      }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No Internet Connection",
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)),
            backgroundColor: AppColors.red,
            behavior: SnackBarBehavior.floating, margin: EdgeInsets.fromLTRB(0, 0, 0, 200)
        ));
      }
    } catch (e) {
      print(e.toString());
    }
    return jsonResponseModelList;
  }

  static Future<List<ChatModel>> makeRequest(
      {required String modelName, required String question,required BuildContext context}) async {
    List<ChatModel> list = [];
    try {
      var response = await http.post(Uri.parse(baseUrl + completions),
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': "Application/json"
          },
          body: jsonEncode(
              {"model": modelName, "prompt": question, "max_tokens": 500}));
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something Went Wrong",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.white)),
          backgroundColor: AppColors.red,
          behavior: SnackBarBehavior.floating,
        ));
        throw HttpException(jsonResponse['error']["message"]);
      }
      if (jsonResponse["choices"].length > 0) {
        list = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
                chatMsg: jsonResponse["choices"][index]["text"], index: 1));
      }
    } catch (e) {
      print(e.toString());
    }
    return list;
  }
}
