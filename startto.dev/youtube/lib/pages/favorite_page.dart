import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:intl/intl.dart';
import 'package:youtube/api.dart';
import 'package:youtube/blocs/favorite_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteBloc = FavoriteBloc();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        initialData: const {},
        stream: favoriteBloc.outFavorite,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: snapshot.data!.values.map((video) {
              var publishedAt = DateFormat("dd/MM/yyyy HH:mm").format(DateTime.parse(video.publishedAt!));
              return InkWell(
                onTap: () {
                  // TODO: Error: Cannot run with sound null safety, because the following dependencies don't support null safety
                  // FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: video.id);
                },
                onLongPress: () => favoriteBloc.toggleFavorite(video),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          video.thumb!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              video.channel,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              publishedAt,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
