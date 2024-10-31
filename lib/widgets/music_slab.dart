import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musix_desktop/logic/provider/audio_provider/audio_provider.dart';
import 'package:musix_desktop/services/util.dart';
import 'package:musix_desktop/widgets/songpage.dart';
import 'package:provider/provider.dart';

class MusicSlab extends StatelessWidget {
  const MusicSlab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        final title =
            audioProvider.title.isNotEmpty ? audioProvider.title : 'Song Name';
        final artist = audioProvider.artist.isNotEmpty
            ? audioProvider.artist
            : 'Artist Name';
        final hexcode = audioProvider.hexcode;
        final thumbnailUrl = audioProvider.thumnail_url;

        // Validate and handle the URL
        String? validateUrl(String? url) {
          if (url == null || url.isEmpty) return null;
          try {
            Uri.parse(url); // Attempt to parse the URL
            return url;
          } catch (e) {
            // Log the error and return a fallback or null
            // print('Invalid URL: $url');
            return null;
          }
        }

        final validThumbnailUrl = validateUrl(thumbnailUrl);

        // Handle empty song data
        if (title == 'Song Name' && artist == 'Artist Name') {
          return const SizedBox(); // Or any other placeholder widget
        }

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const Songpage()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: hexToColor(hexcode),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48, // Add width to ensure the image is visible
                      decoration: BoxDecoration(
                        image: validThumbnailUrl != null
                            ? DecorationImage(
                                image: NetworkImage(validThumbnailUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300], // Placeholder color
                      ),
                      child: validThumbnailUrl == null
                          ? const Icon(Icons.image,
                              size: 48, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 8), // Space between image and text
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            artist,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {}, // Add functionality here
                      icon: const Icon(CupertinoIcons.heart),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<AudioProvider>(context, listen: false)
                            .playPause();
                      }, // Add functionality here
                      icon: audioProvider.isBuffering
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Icon(audioProvider.isPlaying
                              ? CupertinoIcons.pause
                              : CupertinoIcons.play),
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
