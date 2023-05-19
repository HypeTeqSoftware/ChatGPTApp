import 'package:chatbot_app/constants/app_colors.dart';
import 'package:chatbot_app/constants/app_images.dart';
import 'package:chatbot_app/models/theme_model.dart';
import 'package:flutter/material.dart';

class ImagesProvider with ChangeNotifier {
  List<ThemeModel> imageList = [];
  int index = 0;
  int? tempoIndex;
  String imageUrl = AppImages.blueTheme;

  addImage() {
    imageList.add(ThemeModel(
        imageUrl: AppImages.blueTheme,
        senderBubbleColor: AppColors.cyan.shade600,
        receiverBubbleColor: AppColors.cyan.shade900,
        appBarColor: AppColors.cyan.shade900.withOpacity(0.8),
        textFieldColor: AppColors.cyan.shade900.withOpacity(0.8)));
    imageList.add(ThemeModel(
        imageUrl: AppImages.whiteTheme,
        senderBubbleColor: AppColors.blueGrey,
        receiverBubbleColor: AppColors.blueGrey.shade200,
        appBarColor: AppColors.blueGrey.shade200,
        textFieldColor: AppColors.blueGrey.shade200.withOpacity(0.9)));
    imageList.add(ThemeModel(
        imageUrl: AppImages.pinkTheme,
        senderBubbleColor: AppColors.pink.shade300,
        receiverBubbleColor: AppColors.pink.shade900,
        appBarColor: AppColors.pink.shade900,
        textFieldColor: AppColors.pink.shade900.withOpacity(0.8)));
    imageList.add(ThemeModel(
        imageUrl: AppImages.purpleTheme,
        senderBubbleColor: AppColors.deepPurple.shade400,
        receiverBubbleColor: AppColors.deepPurple.shade800,
        appBarColor: AppColors.deepPurple.shade800,
        textFieldColor: AppColors.deepPurple.shade800.withOpacity(0.7)));
    imageList.add(ThemeModel(
        imageUrl: AppImages.greenTheme,
        senderBubbleColor: AppColors.green.shade300,
        receiverBubbleColor: AppColors.teal.shade700,
        appBarColor:  AppColors.teal.shade700,
        textFieldColor:  AppColors.teal.shade700.withOpacity(0.7)));
  }

  Future changeIndex(int i) async {
    index = i;
    notifyListeners();
  }

  tempoStoreIndex(i) {
    tempoIndex = i;
    notifyListeners();
  }

  imageSave() {
    imageUrl = imageList[index].imageUrl;
    notifyListeners();
    print("saved Image ${imageList[index].imageUrl}");
  }
}
