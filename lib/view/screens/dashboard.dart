import 'package:flutter/material.dart';
import 'package:newsmaster/constants/app_constants.dart';
import 'package:newsmaster/view/screens/inner_screens/trending_news_screen.dart';
//import 'package:infinit_test_news/constants/app_constants.dart';
// import 'package:infinit_test_news/view/screens/inner_screens/trending_news_screen.dart';

import '../../utils/navigator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService.instance;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
      ),
      itemCount: MyAppConstants.categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              navigationService.navigate(
                TopTrendingByCategory(
                  newsCategoryModel: MyAppConstants.categories[index],
                ),
              );
            },
            child: Card(
              elevation: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(MyAppConstants.categories[index].icon, size: 50),
                  const SizedBox(height: 10),
                  Text(MyAppConstants.categories[index].name),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
