import 'package:MovieApp/Screens/all_popular_tv_shows_screen.dart';
import 'package:MovieApp/Screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MovieApp/Models/tvShow_model.dart';
import 'package:MovieApp/services/popular_tv_shows.dart';

class PopularTvShowsScreen extends StatefulWidget {
  const PopularTvShowsScreen({super.key});

  @override
  State<PopularTvShowsScreen> createState() => _PopularTvShowsScreenState();
}

class _PopularTvShowsScreenState extends State<PopularTvShowsScreen> {
  List<TVShow> shows = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFirstPage();
  }

  void fetchFirstPage() async {
    List<TVShow> firstPage = await getPopularTVShowsPage(1);
    setState(() {
      shows = firstPage
          .where((s) => s.posterPath.isNotEmpty && s.title.isNotEmpty)
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
                'Popular TV Shows',
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
                      builder: (_) => const AllPopularTvShowsScreen(),
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
                : shows.isEmpty
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
                    itemCount: shows.length,
                    itemBuilder: (context, index) {
                      final show = shows[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(model: show),
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
                                  'https://image.tmdb.org/t/p/w342${show.posterPath}',
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
                                show.title.isNotEmpty
                                ? show.title
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
