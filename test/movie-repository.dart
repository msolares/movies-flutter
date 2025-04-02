import 'package:boardgamesmsf/data/movies/movies-respository.dart';
import 'package:boardgamesmsf/data/movies/movies-service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:boardgamesmsf/domain/movie/movies.dart';

class MockMoviesService extends Mock implements MoviesService {}

void main() {
  late MockMoviesService mockMoviesService;
  late MoviesRepository moviesRepository;

  setUp(() {
    mockMoviesService = MockMoviesService();
    moviesRepository = MoviesRepository(mockMoviesService);
  });

  test('Debe retornar una lista de películas cuando getMovies() es llamado', () async {
    String jsMovie = '''
                      {
                        "adult": false,
                        "backdrop_path": "/gsQJOfeW45KLiQeEIsom94QPQwb.jpg",
                        "genre_ids": [
                          28,
                          53
                        ],
                        "id": 1125899,
                        "original_language": "en",
                        "original_title": "Cleaner",
                        "overview": "Cuando un grupo de activistas radicales se apodera de la gala anual de una empresa energética y toma 300 rehenes, una ex soldado convertida en limpiacristales suspendida 50 pisos en el exterior del edificio debe salvar a los que están atrapados dentro, incluido su hermano pequeño.",
                        "popularity": 482.4115,
                        "poster_path": "/2KIqFpvjVI6mNBTQw7MYZdzRYvs.jpg",
                        "release_date": "2025-02-19",
                        "title": "Cleaner",
                        "video": false,
                        "vote_average": 6.876,
                        "vote_count": 129
                      }
                    ''';


    Movie m = movieFromJson(jsMovie);
    final mockMovies = Movies(results: [m]);

    when(() => mockMoviesService.getMovies()).thenAnswer((_) async {
      print("Mock ejecutado");
      return mockMovies;
    });

    print("Llamando a getMovies() en MoviesRepository...");
    final result = await moviesRepository.getMovies();
    print("Respuesta recibida: $result");

    // Validación
    expect(result, equals(mockMovies));
    // Asegura que se llamó una vez
    verify(() => mockMoviesService.getMovies()).called(1);
    // Verifica que no haya más interacciones
    verifyNoMoreInteractions(mockMoviesService);

    print("Test finalizado correctamente");
  });


}
