import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MovieApp/Models/tvShow_model.dart';
import 'package:MovieApp/Screens/details_screen.dart';
import 'package:MovieApp/services/popular_tv_shows.dart';

class AllPopularTvShowsScreen extends StatefulWidget {
  const AllPopularTvShowsScreen({super.key});

  @override
  State<AllPopularTvShowsScreen> createState() =>
      _AllPopularTvShowsScreenState();
}

class _AllPopularTvShowsScreenState extends State<AllPopularTvShowsScreen> {
  List<TVShow> allShows = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchShows();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading &&
          hasMore) {
        currentPage++;
        fetchShows();
      }
    });
  }

  Future<void> fetchShows() async {
    setState(() => isLoading = true);

    List<TVShow> newShows = await getPopularTVShowsPage(currentPage);
    setState(() {
      if (newShows.isEmpty) {
        hasMore = false;
      } else {
        allShows.addAll(newShows);
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
          'All Popular TV Shows',
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
          itemCount: allShows.length + (isLoading ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            if (index < allShows.length) {
              final show = allShows[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(model: show),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${show.posterPath}',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      show.title,
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
