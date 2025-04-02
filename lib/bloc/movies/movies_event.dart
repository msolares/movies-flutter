part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}


class GetAllGamesEvent extends MoviesEvent{}



class GetPageGamesEvent extends MoviesEvent{
  int page;
  int offset;

  GetPageGamesEvent(this.page, this.offset);
}

class SelectedMovieEvent extends MoviesEvent{
  Movie movie;

  SelectedMovieEvent (this.movie);
}

class GetPageEditorialGamesEvent extends MoviesEvent{
  int page;
  int offset;
  String editorial;

  GetPageEditorialGamesEvent(this.page, this.offset, this.editorial);
}

class GetPageNameGamesEvent extends MoviesEvent{
  int page;
  int offset;
  String name;

  GetPageNameGamesEvent(this.page, this.offset, this.name);
}

class GetPageEditorioalNameGamesEvent extends MoviesEvent{
  int page;
  int offset;
  String editorial;
  String name;

  GetPageEditorioalNameGamesEvent(this.page, this.offset, this.editorial, this.name);
}

class GetGalleryByGameEvent extends MoviesEvent{
  int idGame;

  GetGalleryByGameEvent(this.idGame);

}

class GetChangeLinesProEvent extends MoviesEvent{
  int lines;

  GetChangeLinesProEvent(this.lines);

}

class GetChangeLinesDescEvent extends MoviesEvent{
  int lines;

  GetChangeLinesDescEvent(this.lines);

}
