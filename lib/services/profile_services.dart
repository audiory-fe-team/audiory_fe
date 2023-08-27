import 'dart:convert';

import 'package:audiory_v0/models/Profile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  static final profileEndpoint = "${dotenv.get('API_BASE_URL')}/users";

  Future<List<Profile>> fetchAllProfiles({String keyword = ''}) async {
    final url = Uri.parse(profileEndpoint)
        .replace(queryParameters: {'keyword': keyword ?? ''});
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };
    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      final List result = json.decode(responseBody)['data'];

      return result.map((i) => Profile.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load profiles');
    }
  }

  Future<Profile?> fetchProfileById(String? profileId) async {
    if (profileId == null || profileId == '') {
      return null;
    }
    final url = Uri.parse(profileEndpoint + "/$profileId" + "/profile");
    Map<String, String> header = {
      "Content-type": "application/json",
      "Accept": "application/json"
    };

    final response = await http.get(url, headers: header);
    final responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode == 200) {
      try {
        final Profile profile =
            Profile.fromJson(json.decode(responseBody)['data']);
        return profile;
      } catch (error) {
        throw Exception(error.toString());
      }
    } else {
      throw Exception('Failed to fetch profile');
    }
  }
}
