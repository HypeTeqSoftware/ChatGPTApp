import 'dart:io';
import 'dart:ui';

import 'package:chatbot_app/constants/app_colors.dart';
import 'package:chatbot_app/constants/app_images.dart';
import 'package:chatbot_app/models/models.dart';
import 'package:chatbot_app/constants/connectivity_check.dart';
import 'package:chatbot_app/providers/image_provider.dart';
import 'package:chatbot_app/widgets/add_question_fun.dart';
import 'package:flutter/material.dart';
import 'package:chatbot_app/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<TitleDataModel> list = [];
  List<QuestionsModel> questionList = [];
  TabController? tabController;
  int onTapIndex = 0;
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Colors.blue, Colors.lightGreenAccent],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 210.0, 70.0));
  @override
  void initState() {
    super.initState();
    addTitleData();
    tabBarViewData(questionList);
    tabController = TabController(vsync: this, length: list.length);
    final themeProvider = Provider.of<ImagesProvider>(context, listen: false);
    themeProvider.addImage();
    // themeProvider.imageSave();
    // tabController!.addListener(() {
    //   setState(() {
    //     onTapIndex = tabController!.index;
    //   });
    // });
  }

  addTitleData() {
    list.add(TitleDataModel(text: "Writing email", url: AppImages.email));
    list.add(TitleDataModel(text: "Resumes", url: AppImages.resume));
    list.add(TitleDataModel(text: "Job interview", url: AppImages.interview));
    list.add(TitleDataModel(text: "Math", url: AppImages.math));
    list.add(TitleDataModel(
        text: "Science Questions", url: AppImages.scienceQuestion));
    list.add(TitleDataModel(text: "Developer", url: AppImages.developer));
    list.add(TitleDataModel(text: "Essay", url: AppImages.essay));
    list.add(TitleDataModel(text: "Recipe", url: AppImages.cooking));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.aiLogoWhite, height: 135),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const rive.RiveAnimation.asset("assets/animation/shapes.riv",
              fit: BoxFit.cover),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: const SizedBox(),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TabBar(
                    controller: tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.white24,
                    ),
                    onTap: (val) {
                      setState(() {
                        onTapIndex = val;
                      });
                    },
                    tabs: List<Tab>.generate(list.length, (index) {
                      return Tab(
                        child: Row(
                          children: [
                            Image.asset(list[index].url, height: 30, width: 25),
                            const SizedBox(width: 10),
                            Text(list[index].text)
                          ],
                        ),
                      );
                    })),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                      controller: tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(list.length, (index) {
                        return ListView.builder(
                            itemCount: questionList.length,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  questionList[i].index == onTapIndex
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10.0),
                                          child: GestureDetector(
                                              onTap: () async {
                                                if (await ConnectivityCheck
                                                    .checkInternet()) {
                                                  if (mounted) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatScreen(
                                                                  question:
                                                                      questionList[
                                                                              i]
                                                                          .question),
                                                        ));
                                                  }
                                                } else {
                                                  if (mounted) {
                                                    Platform.isIOS
                                                        ? ConnectivityCheck
                                                            .noInternetDialogIOS(
                                                                context)
                                                        : ConnectivityCheck
                                                            .noInternetDialog(
                                                                context);
                                                  }
                                                }
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                      child: Text(
                                                    questionList[i].question,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  IconButton(
                                                      onPressed: () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ChatScreen(
                                                                        question:
                                                                            questionList[i].question),
                                                              )),
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_right))
                                                ],
                                              )),
                                        )
                                      : const SizedBox(),
                                ],
                              );
                            });
                      })),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 12.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(width: 5,color: AppColors.blueShade900),
              //         borderRadius: BorderRadius.circular(20),
              //     ),
              //     child: SizedBox(
              //       height: 50,
              //       width: MediaQuery.of(context).size.width/2,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: AppColors.pinkShade400,
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(16))),
              //           onPressed: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const Purchase(
              //                     )));
              //           },
              //           child: const Text(
              //             "PLAN BUY",
              //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: AppColors.white),
              //           )),
              //     ),
              //   ),
              // ) ,
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: AppColors.blueShade900),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.pinkShade400,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () async {
                          if (await ConnectivityCheck.checkInternet()) {
                            if (mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            question: "",
                                          )));
                            }
                          } else {
                            if (mounted) {
                              Platform.isIOS
                                  ? ConnectivityCheck.noInternetDialogIOS(
                                      context)
                                  : ConnectivityCheck.noInternetDialog(context);
                            }
                          }
                        },
                        child: const Text(
                          "START CHAT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.white),
                        )),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
