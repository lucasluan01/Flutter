import 'package:buscador_gifs/pages/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:transparent_image/transparent_image.dart';

class GridViewGifs extends StatefulWidget {
  const GridViewGifs({
    super.key,
    required this.buildContext,
    required this.asyncSnapshot,
    required this.onMoreGifs,
    this.search,
  });

  final BuildContext buildContext;
  final AsyncSnapshot asyncSnapshot;
  final String? search;
  final Function() onMoreGifs;

  @override
  State<GridViewGifs> createState() => _GridViewGifsState();
}

class _GridViewGifsState extends State<GridViewGifs> {
  List<dynamic> gifsList = [];

  @override
  void initState() {
    super.initState();
    gifsList = widget.asyncSnapshot.data['data'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 1,
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: gifsList.length + 1,
      itemBuilder: (context, index) {
        if (index < gifsList.length) {
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: gifsList[index]['images']['fixed_height']['url'],
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GifPage(gifData: gifsList[index]),
                ),
              );
            },
            onLongPress: () async {
              await FlutterShare.share(
                title: "Gif: ${gifsList[index]['title']}",
                text: "Gif: ${gifsList[index]['title']}",
                linkUrl: gifsList[index]['images']['fixed_height']['url'],
                chooserTitle: "Gif: ${gifsList[index]['title']}",
              );
            },
          );
        }

        return ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            setState(() {
              widget.onMoreGifs();
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                size: 64,
              ),
              Text(
                'mais',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
