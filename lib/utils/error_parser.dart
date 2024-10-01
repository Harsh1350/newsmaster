import 'dart:io';

class ErrorParser {
  static String parse(dynamic error) {
    if (error is SocketException) {
      return "Unable to connect to the internet. Please check your connection.";
    } else if (error is HttpException) {
      return "Unable to fetch data. Please try again later.";
    } else if (error is FormatException) {
      return "Bad response format. Please try again later.";
    } else {
      return "An unexpected error occurred. Please try again later.";
    }
  }
}
