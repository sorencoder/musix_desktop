import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: non_constant_identifier_names

class SongModel {
  final String id;
  final String title;
  final String artist;
  final String thumbnail_url;
  final String song_url;
  final String hex_code;
  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.thumbnail_url,
    required this.song_url,
    required this.hex_code,
  });

  SongModel copyWith({
    String? id,
    String? title,
    String? artist,
    String? thumbnail_url,
    String? song_url,
    String? hex_code,
  }) {
    return SongModel(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      song_url: song_url ?? this.song_url,
      hex_code: hex_code ?? this.hex_code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'artist': artist,
      'thumbnail_url': thumbnail_url,
      'song_url': song_url,
      'hex_code': hex_code,
    };
  }

  factory SongModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SongModel(
        id: doc.id,
        title: data['title'] ?? 'empty title',
        artist: data['artist'] ?? 'empty artist',
        thumbnail_url: data['thumnail_url'] ?? 'no thumnail url',
        song_url: data['url'] ?? 'no song url',
        hex_code: data['hex_code'] ?? 'no hex code');
  }
}
