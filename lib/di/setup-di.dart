
import 'package:boardgamesmsf/data/movies/movies-respository.dart';
import 'package:boardgamesmsf/data/movies/movies-service.dart';
import 'package:http/http.dart' as http;
import 'package:injector/injector.dart';

import '../bloc/movies/movies_bloc.dart';
import '../data/api-client-http.dart';
import '../data/api-client-interfaz.dart';
import '../use-cases/movies/get-movies-use-case.dart';

void setupDI() {
  final injector = Injector.appInstance;

  // Registrar dependencias
  injector.registerSingleton<ApiClient>(() => HttpApiClient(http.Client()));
  injector.registerDependency<MoviesBloc>(() => MoviesBloc(injector.get<GetMoviesUseCase>()));

  //Inyeccion de movies
  injector.registerSingleton<MoviesService>(() => MoviesService(injector.get<ApiClient>()));
  injector.registerSingleton<MoviesRepository>(() => MoviesRepository(injector.get<MoviesService>()));
  injector.registerSingleton<GetMoviesUseCase>(() => GetMoviesUseCase(injector.get<MoviesRepository>()));


}
