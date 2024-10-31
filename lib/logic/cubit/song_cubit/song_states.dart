import 'package:musix_desktop/data/model/song_model.dart';

abstract class SongStates {
  final List<SongModel> songs;
  SongStates(this.songs);
}

class InitialState extends SongStates {
  InitialState() : super([]);
}

class LoadingState extends SongStates {
  LoadingState(super.songs);
}

class LoadedState extends SongStates {
  LoadedState(super.songs);
}

class ErrorState extends SongStates {
  final String msg;
  ErrorState(this.msg, super.songs);
}
