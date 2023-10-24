import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as https;

class MovieApi {
  Future fetchAlbum() async {
    final uri =
        Uri.parse('https://moviesdatabase.p.rapidapi.com/titles/x/upcoming');

    final response = await https.get(uri, headers: {
      'X-RapidAPI-Key': '8cad75345emsh0283afdb4555eb1p1a3f79jsne23b4f61d6ad',
      'X-RapidAPI-Host': 'moviesdatabase.p.rapidapi.com'
    });
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      var list = json.decode(response.body)['results'] as List;

      var movieList = list.map((model) => MovieModel.fromJson(model)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

class MovieModel {
  final String userId;
  final String id;
  final String title;
  final String image;
  final String captionText;
  final String tyeName;
  final String releaseYear;
  final String releaseDate;
  final String releaseMonth;

  const MovieModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.image,
    required this.captionText,
    required this.releaseDate,
    required this.releaseMonth,
    required this.releaseYear,
    required this.tyeName,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      userId: json['_id'].toString(),
      id: json['id'].toString(),
      title: json['title'].toString(),
      image: json['primaryImage'] != null
          ? json['primaryImage']['url'].toString()
          : '',
      captionText: json['primaryImage'] != null
          ? json['primaryImage']['caption']['plainText'].toString()
          : '',
      releaseDate: json['releaseDate'] != null
          ? json['releaseDate']['day'].toString()
          : "",
      releaseMonth: json['releaseDate'] != null
          ? json['releaseDate']['month'].toString()
          : "",
      releaseYear: json['releaseDate']['year'].toString(),
      tyeName: json['primaryImage'] != null
          ? json['primaryImage']['caption']['__typename'].toString()
          : "",
    );
  }
}
