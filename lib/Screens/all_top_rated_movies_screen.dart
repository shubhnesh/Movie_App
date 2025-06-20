import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MovieApp/Models/movie_model.dart';
import 'package:MovieApp/Screens/details_screen.dart';
import 'package:MovieApp/services/getTopRated.dart';

class AllTopRatedMoviesScreen extends StatefulWidget {
  const AllTopRatedMoviesScreen({super.key});

  @override
  State<AllTopRatedMoviesScreen> createState() =>
      _AllTopRatedMoviesScreenState();
}

class _AllTopRatedMoviesScreenState extends State<AllTopRatedMoviesScreen> {
  List<Movie> movies = [];
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading &&
          hasMore) {
        currentPage++;
        fetchMovies();
      }
    });
  }

  Future<void> fetchMovies() async {
    setState(() => isLoading = true);
    List<Movie> newMovies = await getTopRatedMoviesPage(currentPage);
    setState(() {
      if (newMovies.isEmpty) {
        hasMore = false;
      } else {
        movies.addAll(newMovies);
      }
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Top Rated Movies',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemCount: movies.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < movies.length) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(model: movie),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterURL}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
