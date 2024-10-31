import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musix_desktop/data/model/song_model.dart';
import 'package:musix_desktop/services/firebase_service.dart';

class SongsRepository {
  final firestore = FirebaseService.firestore;

  /// Fetches a list of songs from the Firestore collection.
  ///
  /// Returns:
  /// - A [Future] that resolves to a list of [SongModel].
  Future<List<SongModel>> fetchSongs() async {
    try {
      // Fetch the collection of songs from Firestore
      QuerySnapshot snapshot = await firestore.collection('songs').get();

      // Check if documents are returned
      if (snapshot.docs.isEmpty) {
        return []; // Return an empty list if no documents are found
      }

      // Convert documents to SongModel instances
      List<SongModel> songs =
          snapshot.docs.map((doc) => SongModel.fromDocument(doc)).toList();

      return songs;
    } catch (e) {
      // Log or handle the error as necessary
      // print('Error fetching songs: $e');
      rethrow; // Re-throw the exception to be handled by the caller
    }
  }
}
