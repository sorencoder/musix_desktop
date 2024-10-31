import 'package:musix_desktop/data/model/song_model.dart';

abstract class MadeForYouStates {
  final List<SongModel> madeForYou;
  MadeForYouStates(this.madeForYou);
}

class MFAInitialState extends MadeForYouStates {
  MFAInitialState() : super([]);
}

class MFALoadingState extends MadeForYouStates {
  MFALoadingState(super.madeForYou);
}

class MFALoadedState extends MadeForYouStates {
  MFALoadedState(super.madeForYou);
}

class MFAErrorState extends MadeForYouStates {
  final String message;
  MFAErrorState(this.message, super.madeForYou);
}
