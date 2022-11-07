import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class GifPage extends StatelessWidget {
  const GifPage({
    super.key,
    required this.gifData,
  });

  final Map gifData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gifData['title'],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FlutterShare.share(
                title: "Gif: ${gifData['title']}",
                text: "Gif: ${gifData['title']}",
                linkUrl: gifData['images']['fixed_height']['url'],
                chooserTitle: "Gif: ${gifData['title']}",
              );
            },
            icon: const Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      body: Center(
        child: Image.network(
          gifData['images']['fixed_height']['url'],
        ),
      ),
    );
  }
}
