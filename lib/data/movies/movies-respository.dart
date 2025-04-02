import '../../domain/movie/movies.dart';

class MoviesRepository {
  final _moviesService;
  MoviesRepository(this._moviesService);
  //Todo, se puede recibir en getGames la localización para obtener el idioma del pais donde estes. o el idioma en el que esté configurado el movil
  Future<Movies> getMovies() async =>  await _moviesService.getMovies();
}