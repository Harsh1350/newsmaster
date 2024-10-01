import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/news_category.dart';

class MyAppConstants {
  static const String appName = "NewsInfinit";

  static String get apiKey => dotenv.env['API_KEY'] ?? "";
  static const String baseUrl = "newsapi.org";

  static List<NewsCategoryModel> categories = [
    NewsCategoryModel(
      name: 'Business',
      icon: Icons.business,
    ),
    NewsCategoryModel(
      name: 'Entertainment',
      icon: Icons.movie,
    ),
    NewsCategoryModel(
      name: 'General',
      icon: Icons.public,
    ),
    NewsCategoryModel(
      name: 'Health',
      icon: Icons.health_and_safety,
    ),
    NewsCategoryModel(
      name: 'Science',
      icon: Icons.science,
    ),
    NewsCategoryModel(
      name: 'Sports',
      icon: Icons.sports_soccer,
    ),
    NewsCategoryModel(
      name: 'Technology',
      icon: Icons.computer,
    ),
  ];
}
