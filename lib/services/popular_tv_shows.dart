import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/tvShow_model.dart';

Future<List<TVShow>> getPopularTVShowsPage(int page) async {
  final url =
      'https://api.themoviedb.org/3/tv/popular?language=en-US&page=$page&api_key=c9c1bf6f7a85debbedec3cbb3ee5e30b';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) return [];

  final result = json.decode(response.body);
  final List<dynamic> showsJson = result["results"];

  return showsJson
      .map(
        (show) => TVShow(
          id: show['id'],
          title: show['name'] ?? '',
          overview: show['overview'] ?? '',
          posterPath: show['poster_path'] ?? '',
          backdropPath: show['backdrop_path'] ?? '',
          firstAirDate: show['first_air_date'] ?? '',
          voteAverage: show['vote_average'].toString(),
        ),
      )
      .toList();
}
