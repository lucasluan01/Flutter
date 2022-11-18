import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube/blocs/favorite_bloc.dart';
import 'package:youtube/models/video.dart';

final favoriteBloc = FavoriteBloc();

class VideoTile extends StatelessWidget {
  const VideoTile({
    super.key,
    required this.video,
  });

  final Video video;

  @override
  Widget build(BuildContext context) {
    var publishedAt = DateFormat("dd/MM/yyyy HH:mm").format(DateTime.parse(video.publishedAt!));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            video.thumb!,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          video.channel!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 2,
                          width: 2,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          publishedAt,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<Map<String, Video>>(
              initialData: const {},
              stream: favoriteBloc.outFavorite,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
                return IconButton(
                  onPressed: () {
                    favoriteBloc.toggleFavorite(video);
                  },
                  icon: Icon(
                    snapshot.data!.containsKey(video.id!) ? Icons.favorite : Icons.favorite_border,
                    color: snapshot.data!.containsKey(video.id!) ? Colors.red : Colors.white38,
                    size: 28,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
