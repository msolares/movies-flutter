// ignore_for_file: prefer_const_constructors



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import '../../bloc/movies/movies_bloc.dart';
import '../../components/generic/show-dialog.dart';
import '../../components/movies/card-movie.dart';
import '../../domain/movie/movies.dart';
import 'detail-movie.dart';

class ListMovies extends StatefulWidget {
  const ListMovies({super.key});

  @override
  State<ListMovies> createState() => _ListMoviesState();
}

class _ListMoviesState extends State<ListMovies> {
  MoviesBloc _moviesBloc = Injector.appInstance.get<MoviesBloc>();
  List<Movie> movies = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int currentPage = 0;

  void _ontap(Movie movie){
    // context.read<MoviesBloc>().add(SelectedMovieEvent(movie));
    Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => DetailMovie(movie)
      )
    );
  }

  @override
  void initState() {
    _moviesBloc.add(GetPageGamesEvent(currentPage, 20));
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (isLoading) return;
      setState(() => isLoading = true);
      currentPage++;
      _moviesBloc.add(GetPageGamesEvent(currentPage, 20));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _moviesBloc,
      child: BlocListener<MoviesBloc, MoviesState>(
        listener: (context, state) {
          if(state is GetMoviesState){
            setState(() {
              isLoading = false;
              if (movies.isEmpty) {
                movies = state.movies;
              }else{
                movies.addAll(state.movies);
              }
            });
          }else if (state is ErrorState){
            ShowDialog().dialogBuilder(context, "Aviso", "No se han podido encontrar juegos, inténtal más tade");
          }
        },
        child: Scaffold(
          body: GridView.builder(
            controller: _scrollController,
            itemCount: movies.length + (isLoading ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index == movies.length) {
                return const Center(child: CircularProgressIndicator()); // Loader
              }
              return InkWell(
                onTap: (){
                  _ontap(movies[index]);
                },
                child: CardMovie().getCardMovie(movies[index])
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:2,
              childAspectRatio: 1, // Mantener cuadrado
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
          ),
        ),
      ),
    );
  }
}
