import 'package:chatbot_app/constants/app_colors.dart';
import 'package:chatbot_app/providers/image_provider.dart';
import 'package:chatbot_app/providers/models_provider.dart';
import 'package:chatbot_app/providers/send_message_provider.dart';
import 'package:chatbot_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelsProvider()),
        ChangeNotifierProvider(create: (_) => SendMessageProvider()),
        ChangeNotifierProvider(create: (_) => ImagesProvider()),
      ],
      child: MaterialApp(
        title: 'Chatbot app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.cyan,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.black,
          appBarTheme: const AppBarTheme(color: AppColors.black),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
