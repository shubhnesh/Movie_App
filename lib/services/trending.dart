import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/movie_model.dart';

Future<List<Movie>> getTrendingMoviesPage(int page) async {
  final url =
      'https://api.themoviedb.org/3/trending/movie/day?language=en-US&page=$page&api_key=c9c1bf6f7a85debbedec3cbb3ee5e30b';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) return [];

  final result = json.decode(response.body);
  final List<dynamic> moviesJson = result["results"];

  return moviesJson
      .map(
        (json) => Movie(
          about: json['overview'],
          backdropURL: json["backdrop_path"] ?? '',
          posterURL: json['poster_path'] ?? '',
          release: json['release_date'] ?? '',
          title: json['title'] ?? '',
          voteAverage: json['vote_average'].toString(),
          id: json['id'],
        ),
      )
      .toList();
}
