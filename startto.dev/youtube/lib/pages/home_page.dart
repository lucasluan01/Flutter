import 'package:flutter/material.dart';
import 'package:youtube/blocs/favorite_bloc.dart';
import 'package:youtube/blocs/videos_bloc.dart';
import 'package:youtube/delegates/data_search.dart';
import 'package:youtube/models/video.dart';
import 'package:youtube/pages/favorite_page.dart';
import 'package:youtube/widgets/video_tile.dart';

final videosBloc = VideosBloc();
final favoriteBloc = FavoriteBloc();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          SizedBox(
            height: 25,
            child: Image.asset("images/youtube-logo.png"),
          ),
          const SizedBox(width: 12),
          const Text(
            "YouTube",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
        actions: [
          IconButton(
            onPressed: () async {
              String? result = await showSearch(
                context: context,
                delegate: DataSearch(),
              );

              if (result != null) {
                videosBloc.inSearch.add(result);
              }
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritePage()));
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),
              // TODO: O Bloc não está funcionando
              StreamBuilder<Map<String, Video>>(
                  initialData: const {},
                  stream: favoriteBloc.outFavorite,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    return Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          "${snapshot.data!.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  }),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder(
        stream: videosBloc.outVideos,
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 12),
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(
                    video: snapshot.data[index],
                  );
                }
                videosBloc.inSearch.add("");

                return const SizedBox(
                  height: 80,
                  width: 80,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
