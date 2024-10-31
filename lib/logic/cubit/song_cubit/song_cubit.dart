import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_desktop/logic/cubit/song_cubit/song_states.dart';
import 'package:musix_desktop/data/model/song_model.dart';
import 'package:musix_desktop/repositories/song_repository.dart';

class SongCubit extends Cubit<SongStates> {
  SongCubit() : super(InitialState()) {
    _initialize();
  }

  final _songRepository = SongsRepository();
  void _initialize() async {
    emit(LoadingState(state.songs));
    try {
      List<SongModel> songs = await _songRepository.fetchSongs();
      emit(LoadedState(songs));
    } catch (e) {
      emit(ErrorState(e.toString(), state.songs));
    }
  }

  void get refresh => _initialize();
}
