import 'package:chatbot_app/constants/app_colors.dart';
import 'package:chatbot_app/constants/app_images.dart';
import 'package:chatbot_app/providers/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ImagesProvider>(context, listen: false).tempoIndex = null;
  }

  int storedIndex = 0;
  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(AppImages.blueTheme), context);
    precacheImage(const AssetImage(AppImages.pinkTheme), context);
    precacheImage(const AssetImage(AppImages.purpleTheme), context);
    precacheImage(const AssetImage(AppImages.whiteTheme), context);
    precacheImage(const AssetImage(AppImages.greenTheme), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Theme"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Consumer<ImagesProvider>(builder: (context, snapshot, _) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.5),
                      ),
                      itemCount: snapshot.imageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            print(index);
                            setState(() {
                              storedIndex = index;
                            });
                            snapshot.tempoStoreIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: snapshot.index == index
                                  ? Border.all(color: AppColors.white, width: 4)
                                  : snapshot.tempoIndex == index
                                      ? Border.all(
                                          color: AppColors.pink, width: 4)
                                      : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                snapshot.imageList[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () {
                    Provider.of<ImagesProvider>(context, listen: false)
                        .changeIndex(storedIndex)
                        .then((_) {
                      Provider.of<ImagesProvider>(context, listen: false)
                          .imageSave();
                      // Provider.of<SendMessageProvider>(context,listen: false).clearChat();
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "APPLY",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
