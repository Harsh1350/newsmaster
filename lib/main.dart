import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsmaster/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'constants/theme_data.dart';
import 'view_models/news_provider.dart';
import 'view_models/theme_provider.dart';
import 'view/screens/home_screen.dart';
import 'services/news_service.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return NewsProvider(NewsService());
        }),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return MaterialApp(
          title: MyAppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
            isDarkTheme: themeProvider.isDarkTheme,
            context: context,
          ),
          home: const MainScreen(),
        );
      }),
    );
  }
}
