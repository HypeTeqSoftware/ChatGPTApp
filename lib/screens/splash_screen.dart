import 'package:chatbot_app/constants/app_images.dart';
import 'package:chatbot_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(parent: _controller!, curve: Curves.easeIn);
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 3700),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen())),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue.shade300,
          Colors.cyan.shade200,
          Colors.green.shade100,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: FadeTransition(
        opacity: _animation!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.aiLogoBlack,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
