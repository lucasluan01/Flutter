import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:youtube/models/video.dart';

// ignore: constant_identifier_names
const String API_KEY = "AIzaSyAhKvb3xleVrog0683twOY8uYE7-ESRqJc";

class Api {
  String _search = "";
  String _nextPage = "";

  Future<List<Video>> search(String search) async {
    _search = search;

    var response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"),
    );

    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    var response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextPage"),
    );

    return decode(response);
  }

  List<Video> decode(response) {
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      _nextPage = jsonResponse["nextPageToken"];

      List<Video> videos = jsonResponse["items"].map<Video>((item) => Video.fromJson(item)).toList();

      return videos;
    } else {
      throw Exception("Request failed with status: ${response.statusCode}.");
    }
  }
}

// "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"