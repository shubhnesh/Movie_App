import 'package:MovieApp/Models/details_model.dart';

class TVShow implements DetailsModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String firstAirDate;
  final String voteAverage;

  TVShow({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.firstAirDate,
    required this.voteAverage,
  });

  @override
  String get releaseDate => firstAirDate;
}
