import 'package:MovieApp/Screens/popular_tv_shows_screen.dart';
import 'package:MovieApp/Screens/top_rated_movies_screen.dart';
import 'package:MovieApp/Screens/trending_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = 'c9c1bf6f7a85debbedec3cbb3ee5e30b';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjOWMxYmY2ZjdhODVkZWJiZWRlYzNjYmIzZWU1ZTMwYiIsIm5iZiI6MTc1MDIzNzI1Mi4zMTgsInN1YiI6IjY4NTI4MDQ0NDg0ZTc4MDdlYTA2NjA1NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ydWXkiFmgD3zvgdZgT9XMdGybWvhU0JGT1o_m5JaOTc';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Movie App',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: const [
          TrendingMovies(),
          TopRatedMoviesScreen(),
          PopularTvShowsScreen(),
        ],
      ),
    );
  }
}
