import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MovieApp/Models/movie_model.dart';
import 'package:MovieApp/Screens/all_trending_movies_screen.dart';
import 'package:MovieApp/Screens/details_screen.dart';
import 'package:MovieApp/services/trending.dart';

class TrendingMovies extends StatefulWidget {
  const TrendingMovies({Key? key}) : super(key: key);

  @override
  State<TrendingMovies> createState() => _TrendingMoviesState();
}

class _TrendingMoviesState extends State<TrendingMovies> {
  List<Movie> trendingMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFirstPage();
  }

  void fetchFirstPage() async {
    List<Movie> pageOne = await getTrendingMoviesPage(1);
    setState(() {
      trendingMovies = pageOne
          .where((m) => m.posterURL.isNotEmpty && m.title.isNotEmpty)
          .take(10)
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending Movies',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllTrendingMoviesScreen(),
                    ),
                  );
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 270,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : trendingMovies.isEmpty
                ? Center(
                    child: Text(
                      'See All',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: trendingMovies.length,
                    itemBuilder: (context, index) {
                      final movie = trendingMovies[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(model: movie),
                            ),
                          );
                        },
                        child: Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w342${movie.posterURL}',
                                  height: 200,
                                  width: 140,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          height: 200,
                                          width: 140,
                                          color: Colors.grey[900],
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        height: 200,
                                        width: 140,
                                        color: Colors.grey[800],
                                        child: const Icon(Icons.broken_image),
                                      ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                movie.title.isNotEmpty
                                    ? movie.title
                                    : 'No Title',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
