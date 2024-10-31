import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musix_desktop/data/model/song_model.dart';
import 'package:musix_desktop/services/firebase_service.dart';

class MadeForYouRepo {
  final firestore = FirebaseService.firestore;
  Future<List<SongModel>> fetchSongs(String userId) async {
    try {
      // Fetch made for you for the specific user with play count greater than 5
      QuerySnapshot snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('made_for_you')
          .orderBy('playCount')
          .limit(10)
          .get();
      return snapshot.docs.map((doc) => SongModel.fromDocument(doc)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
