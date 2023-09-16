import 'package:flutter_dotenv/flutter_dotenv.dart';

class Endpoints {
  late String user;
  late String story;
  late String chapter;
  late String chapterVersion;

  Endpoints() {
    // base url
    String baseUrl = dotenv.get('API_BASE_URL');

    //entities endpoints
    user = "$baseUrl/users";
    story = "$baseUrl/stories";
    chapter = "$baseUrl/chapters";
    chapterVersion = "$baseUrl/chapter-version";
  }

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;
}
