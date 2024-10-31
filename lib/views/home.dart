// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_desktop/logic/cubit/made_for_you/made_for_you_cubit.dart';
import 'package:musix_desktop/logic/cubit/made_for_you/made_for_you_states.dart';
import 'package:musix_desktop/logic/cubit/song_cubit/song_cubit.dart';
import 'package:musix_desktop/logic/cubit/song_cubit/song_states.dart';
import 'package:musix_desktop/widgets/album_card.dart';
import 'package:musix_desktop/widgets/song_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .6,
            decoration: const BoxDecoration(
              color: Color(0xFf1C7A74),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(1),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Good evening",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.history),
                              SizedBox(width: 16),
                              Icon(Icons.settings),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 10, right: 16, left: 16, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              RowAlbumCard(
                                label: "Top 50",
                                image: AssetImage("assets/top50.jpg"),
                              ),
                              SizedBox(width: 10),
                              RowAlbumCard(
                                label: "Liked",
                                image: AssetImage("assets/liked.jpg"),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              RowAlbumCard(
                                label: "RapCaviar",
                                image: AssetImage("assets/album2.jpg"),
                              ),
                              SizedBox(width: 10),
                              RowAlbumCard(
                                label: "Eminem",
                                image: AssetImage("assets/album5.jpg"),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              RowAlbumCard(
                                label: "Top 50 - USA",
                                image: AssetImage("assets/album9.jpg"),
                              ),
                              SizedBox(width: 10),
                              RowAlbumCard(
                                label: "Pop Remix",
                                image: AssetImage("assets/album10.jpg"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Recently played",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        // const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: SizedBox(
                            height: 140,
                            child: BlocBuilder<SongCubit, SongStates>(
                              builder: (context, state) {
                                if (state is LoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.songs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final data = state.songs[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: AlbumCard(
                                        song: data,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 10, bottom: 5),
                          child: Text(
                            "Made for you",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        // const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: SizedBox(
                            height: 160,
                            child:
                                BlocBuilder<MadeForYouCubit, MadeForYouStates>(
                              builder: (context, state) {
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.madeForYou.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final data = state.madeForYou[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: AlbumCard(
                                        song: data,
                                        size: 140,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 10, bottom: 5),
                          child: Text(
                            "Recommended radio",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Row(
                            children: [
                              SongCard(
                                image: AssetImage("assets/album8.jpg"),
                              ),
                              SizedBox(width: 16),
                              SongCard(
                                image: AssetImage("assets/album5.jpg"),
                              ),
                              SizedBox(width: 16),
                              SongCard(
                                image: AssetImage("assets/album6.jpg"),
                              ),
                              SizedBox(width: 16),
                              SongCard(
                                image: AssetImage("assets/album1.jpg"),
                              ),
                              SizedBox(width: 16),
                              SongCard(
                                image: AssetImage("assets/album3.jpg"),
                              ),
                              SizedBox(width: 16),
                              SongCard(
                                image: AssetImage("assets/album10.jpg"),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowAlbumCard extends StatelessWidget {
  final AssetImage image;
  final String label;

  const RowAlbumCard({super.key, required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => AlbumView(
          //       song: ,
          //     ),
          //   ),
          // );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Image(
                image: image,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Text(label)
            ],
          ),
        ),
      ),
    );
  }
}
