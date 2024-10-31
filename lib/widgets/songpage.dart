import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musix_desktop/logic/provider/audio_provider/audio_provider.dart';
import 'package:musix_desktop/services/util.dart';
import 'package:provider/provider.dart';

class Songpage extends StatefulWidget {
  const Songpage({super.key});

  @override
  State<Songpage> createState() => _SongpageState();
}

class _SongpageState extends State<Songpage> {
  String formatTime(Duration duration) {
    final String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final String formattedTime = "${duration.inMinutes}:${twoDigitSeconds}";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<AudioProvider>(
      builder: (context, v, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  hexToColor(v.hexcode),
                  const Color.fromARGB(255, 61, 65, 64)
                ])),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      // height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(v.thumnail_url),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(v.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(color: Colors.white)),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(v.artist,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor:
                                    Colors.white.withOpacity(0.117),
                                thumbColor: Colors.white,
                                trackHeight: 4,
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                min: 0,
                                max: v.duration.inSeconds.toDouble(),
                                value: v.isCompleted
                                    ? 0
                                    : v.position.inSeconds.toDouble(),
                                onChangeEnd: (value) {
                                  v.seek(value);
                                },
                                onChanged: (val) {
                                  // Optionally handle slider change
                                  v.sliderChange(val);
                                },
                                activeColor: Colors.white,
                                inactiveColor: Colors.grey,
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Current position
                                    Text(
                                      formatTime(v.isCompleted
                                          ? Duration.zero
                                          : v.position),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    // Total duration
                                    Text(formatTime(v.duration),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.skip_previous,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                onPressed: () {
                                  // Handle back navigation
                                },
                              ),
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: IconButton(
                                  icon: v.isBuffering
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                      : v.isCompleted
                                          ? const Icon(Icons.play_arrow,
                                              color: Colors.white)
                                          : Icon(
                                              color: Colors.white,
                                              size: 70,
                                              v.isPlaying
                                                  ? CupertinoIcons.pause_circle
                                                  : CupertinoIcons.play_circle,
                                            ),
                                  iconSize: 60,
                                  onPressed: () {
                                    v.isCompleted ? v.play() : v.playPause();
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.skip_next,
                                    size: 50, color: Colors.white),
                                onPressed: () {
                                  // Handle forward navigation
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
