

import 'package:boardgamesmsf/domain/movie/movies.dart';
import 'package:boardgamesmsf/util/api-key.dart';


import '../../entorno.dart';
import '../api-client-interfaz.dart';

class MoviesService {
  final ApiClient apiClient;
  MoviesService(this.apiClient);

  Future<Movies> getMovies() async{
    var headers = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${Apikey().getApiKey()}'
    };

    final response = await apiClient.get('${Entorno.getEntorno()}popular?language=es-ES',  headers);
    Movies rg = moviesFromJson(response);
    return rg;
  }
}