import 'package:MovieApp/Models/details_model.dart';

class Movie implements DetailsModel {
  String backdropURL;
  String posterURL;
  String title;
  String about;
  String voteAverage;
  String release;
  int id;

  Movie({
    required this.about,
    required this.backdropURL,
    required this.posterURL,
    required this.release,
    required this.title,
    required this.voteAverage,
    required this.id,
  });

  @override
  String get overview => about;

  @override
  String get posterPath => posterURL;

  @override
  String get backdropPath => backdropURL;

  @override
  String get releaseDate => release;
}
