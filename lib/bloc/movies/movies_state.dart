part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class GamesInitial extends MoviesState {}

class GetMoviesState extends MoviesState{
  List<Movie> movies;
  GetMoviesState(this.movies);
}

class ErrorState extends MoviesState{
  String error;
  ErrorState (this.error);
}

class GetChangeLinesProState extends MoviesState{
  int lines;
  GetChangeLinesProState(this.lines);
}

class GetChangeLinesDescState extends MoviesState{
  int lines;
  GetChangeLinesDescState(this.lines);
}

class SelectedMovieState extends MoviesState{
  Movie movie;

  SelectedMovieState (this.movie);
}
