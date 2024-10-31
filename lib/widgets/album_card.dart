import 'package:flutter/material.dart';
import 'package:musix_desktop/data/model/song_model.dart';
import 'package:musix_desktop/views/album_view.dart';

class AlbumCard extends StatelessWidget {
  final SongModel song;
  final Function? onTap;
  final double size;

  const AlbumCard({super.key, required this.song, this.onTap, this.size = 120});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumView(
              song: song,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: NetworkImage(song.thumbnail_url),
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
          // SizedBox(height: 10),
          SizedBox(
            width: 120,
            child: Text(
              song.title,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
