import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';
import '../constants/app_constants.dart';

class NewsService {
  Future<List<NewsModel>> fetchAllNews(int page) async {
    var uri = Uri.https(
      MyAppConstants.baseUrl,
      '/v2/everything',
      {
        'domains': 'techcrunch.com',
        'sortBy': 'publishedAt',
        'pageSize': '10',
        'page': page.toString(),
        'apiKey': MyAppConstants.apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['articles'] != null) {
        return (data['articles'] as List)
            .map((article) => NewsModel.fromJson(article))
            .toList();
      } else {
        throw const HttpException('No articles found');
      }
    } else {
      throw const HttpException('Failed to fetch news');
    }
  }

  Future<List<NewsModel>> fetchNewsByCategory(String category, int page) async {
    var uri = Uri.https(
      MyAppConstants.baseUrl,
      '/v2/top-headlines',
      {
        'country': 'us',
        'category': category,
        'pageSize': '10',
        'page': page.toString(),
        'apiKey': MyAppConstants.apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['articles'] != null) {
        return (data['articles'] as List)
            .map((article) => NewsModel.fromJson(article))
            .toList();
      } else {
        throw const HttpException('No articles found in this category');
      }
    } else {
      throw const HttpException('Failed to fetch news by category');
    }
  }
}
