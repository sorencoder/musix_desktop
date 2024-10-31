import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_desktop/data/model/song_model.dart';
import 'package:musix_desktop/logic/cubit/made_for_you/made_for_you_states.dart';
import 'package:musix_desktop/repositories/made_for_you_repo.dart';

class MadeForYouCubit extends Cubit<MadeForYouStates> {
  MadeForYouCubit() : super(MFAInitialState()) {
    _initialize();
  }

  final _madeForYou = MadeForYouRepo();
  void _initialize() async {
    emit(MFALoadingState(state.madeForYou));
    try {
      List<SongModel> songs =
          await _madeForYou.fetchSongs('BQQ4LpCTPDUlayCVhhYc3UTwMkU2');
      emit(MFALoadedState(songs));
    } catch (e) {
      emit(MFAErrorState(e.toString(), state.madeForYou));
    }
  }
}
