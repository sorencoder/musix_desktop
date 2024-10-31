import 'package:flutter/material.dart';
import 'package:musix_desktop/data/model/song_model.dart';
import 'package:musix_desktop/logic/provider/audio_provider/audio_provider.dart';
import 'package:musix_desktop/services/util.dart';
import 'package:musix_desktop/widgets/music_slab.dart';
import 'package:provider/provider.dart';

class AlbumView extends StatefulWidget {
  final SongModel song;

  const AlbumView({super.key, required this.song});

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late ScrollController scrollController;

  double imageSize = 240;
  double containerHeight = 500;
  bool showTopBar = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        final offset = scrollController.offset;
        setState(() {
          imageSize = (240 - offset).clamp(0, 240);
          containerHeight = (500 - offset).clamp(0, 500);
          showTopBar = offset > 224;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildHeader(context),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildSongDetails(context),
                  _buildPlayButton(context),
                ],
              ),
            ),
          ),
          _buildAppBar(context),
          const Positioned(bottom: 0, child: MusicSlab())
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: containerHeight,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [hexToColor(widget.song.hex_code), Colors.black],
              stops: const [0.5, 1])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: (imageSize / 240).clamp(0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    offset: const Offset(0, 20),
                    blurRadius: 32,
                    spreadRadius: 16,
                  ),
                ],
              ),
              child: Image.network(
                widget.song.thumbnail_url,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSongDetails(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: [
      //       Colors.black.withOpacity(0),
      //       Colors.black.withOpacity(0),
      //       Colors.black.withOpacity(1),
      //     ],
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 240 + 32),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.song.title,
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Image.asset('assets/logo.png', width: 32, height: 32),
                      const SizedBox(width: 8),
                      const Text("Spotify"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("1,888,132 likes 5h 3m",
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 16),
                  const Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite),
                          SizedBox(width: 16),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayButton(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.song.title),
          subtitle: Text(widget.song.artist),
        ),
        ListTile(
          title: Text(widget.song.title),
          subtitle: Text(widget.song.artist),
        ),
        ListTile(
          title: Text(widget.song.title),
          subtitle: Text(widget.song.artist),
        ),
        ListTile(
          title: Text(widget.song.title),
          subtitle: Text(widget.song.artist),
        ),
        ListTile(
          title: Text(widget.song.title),
          subtitle: Text(widget.song.artist),
        ),
        ListTile(
          title: Text(widget.song.title),
          subtitle: Text(widget.song.artist),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Positioned(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: showTopBar
            ? hexToColor(widget.song.hex_code).withOpacity(1)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.keyboard_arrow_left, size: 38),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: showTopBar ? 1 : 0,
                  child: Text(widget.song.title,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Positioned(
                  right: 0, // Added padding from the right edge
                  bottom: 80 - containerHeight.clamp(120.0, double.infinity),
                  child: Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 50, 193, 105),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<AudioProvider>(context, listen: false)
                            .setSource(widget.song);
                        print('Play button tapped');
                      },
                      child: const Icon(Icons.play_arrow,
                          size: 38, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
