import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/theme_provider.dart';
import 'allnews_screen.dart';
import 'dashboard.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
          actions: [
            IconButton(
              icon: Icon(
                themeProvider.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: () {
                themeProvider.setDarkTheme(!themeProvider.isDarkTheme);
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Dashboard'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NewsScreen(),
            DashboardScreen(),
          ],
        ),
      ),
    );
  }
}
