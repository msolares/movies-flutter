import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/movie/movies.dart';
import '../../use-cases/movies/get-movies-use-case.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUseCase getGamePageUseCase;

  MoviesBloc(this.getGamePageUseCase) : super(GamesInitial()) {
    on<GetPageGamesEvent>((event, emit) async{
      final movies = await getGamePageUseCase.GetMovies();
      //todo controlar erores
      emit(GetMoviesState(movies.results ?? []));
    });

    // on<GetGalleryByGameEvent>((event, emit) async{
    //   final responseGames = await getGalleryUseCase.GetGalley(event.idGame);
    //   if (responseGames.errorCode == 200 || responseGames.errorCode == 201) {
    //     emit(GetgalleryState(responseGames.galeria));
    //   }else{
    //     emit(ErrorState(responseGames.errorDesc));
    //   }
    // });
    on<GetChangeLinesProEvent>((event, emit) async{
      emit(GetChangeLinesProState(event.lines));
    });
    on<GetChangeLinesDescEvent>((event, emit) async{
      emit(GetChangeLinesDescState(event.lines));
    });
    on<SelectedMovieEvent>((event, emit) async{
      emit(SelectedMovieState(event.movie));
    });
  }
}
