import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';
import '../utils/error_parser.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService;

  // Constructor requires NewsService
  NewsProvider(this._newsService);

  // Variables for fetchAllNews
  final List<NewsModel> _allNewsList = [];
  bool _hasMoreAllNews = true;
  int _currentPageAllNews = 1;
  String? _fetchAllNewsError;
  bool _isLoadingAllNews = false;

  // Variables for fetchNewsByCategory
  final List<NewsModel> _categoryNewsList = [];
  bool _hasMoreCategoryNews = true;
  int _currentPageCategoryNews = 1;
  String? _fetchCategoryNewsError;
  bool _isLoadingCategoryNews = false;

  // Getters for fetchAllNews
  List<NewsModel> get allNewsList => _allNewsList;
  bool get hasMoreAllNews => _hasMoreAllNews;
  String? get fetchAllNewsError => _fetchAllNewsError;
  bool get isLoadingAllNews => _isLoadingAllNews;

  // Getters for fetchNewsByCategory
  List<NewsModel> get categoryNewsList => _categoryNewsList;
  bool get hasMoreCategoryNews => _hasMoreCategoryNews;
  String? get fetchCategoryNewsError => _fetchCategoryNewsError;
  bool get isLoadingCategoryNews => _isLoadingCategoryNews;

  // Method to fetch all news
  Future<void> fetchAllNews({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPageAllNews = 1;
      _allNewsList.clear();
      _fetchAllNewsError = null;
      _hasMoreAllNews = true;
    }
    if (!_hasMoreAllNews) return;

    _isLoadingAllNews = true;
    notifyListeners();

    try {
      List<NewsModel> loadedNews =
          await _newsService.fetchAllNews(_currentPageAllNews);

      if (loadedNews.isEmpty) {
        _hasMoreAllNews = false;
      } else {
        _allNewsList.addAll(loadedNews);
        _currentPageAllNews++;
      }
      notifyListeners();
    } catch (error) {
      log("error $error");
      _fetchAllNewsError = ErrorParser.parse(error);
      notifyListeners();
    } finally {
      _isLoadingAllNews = false;
      notifyListeners();
    }
  }

  // Method to fetch news by category
  Future<void> fetchNewsByCategory(String category,
      {bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPageCategoryNews = 1;
      _categoryNewsList.clear();
      _fetchCategoryNewsError = null;
      _hasMoreCategoryNews = true;
    }
    if (!_hasMoreCategoryNews) return;

    _isLoadingCategoryNews = true;
    notifyListeners();

    try {
      List<NewsModel> loadedNews = await _newsService.fetchNewsByCategory(
          category, _currentPageCategoryNews);

      if (loadedNews.isEmpty) {
        _hasMoreCategoryNews = false;
      } else {
        _categoryNewsList.addAll(loadedNews);
        _currentPageCategoryNews++;
      }
      notifyListeners();
    } catch (error) {
      _fetchCategoryNewsError = ErrorParser.parse(error);
      notifyListeners();
    } finally {
      _isLoadingCategoryNews = false;
      notifyListeners();
    }
  }

  NewsModel? findByDate({String? publishedAt, bool isTrending = false}) {
    if (publishedAt == null) {
      return null;
    } else if (isTrending) {
      return categoryNewsList.firstWhere(
        (element) => element.publishedAt == publishedAt,
      );
    } else {
      return allNewsList.firstWhere(
        (element) => element.publishedAt == publishedAt,
      );
    }
  }
}
