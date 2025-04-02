
import 'package:boardgamesmsf/data/movies/movies-respository.dart';

import '../../domain/movie/movies.dart';

class GetMoviesUseCase {
  MoviesRepository moviesRepository;
  GetMoviesUseCase(this.moviesRepository);
  Future<Movies> GetMovies() async {
    return await moviesRepository.getMovies();
  }
}