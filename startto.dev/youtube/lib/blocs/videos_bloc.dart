import 'dart:async';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube/api.dart';
import 'package:youtube/models/video.dart';

class VideosBloc implements BlocBase {
  late Api api;
  List<Video> videos = [];
  final _videosController = StreamController<List<Video>>();
  final _searchController = StreamController<String>();

  Stream get outVideos => _videosController.stream;

  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(
      (event) => _search(event),
    );
  }

  void _search(String search) async {
    if (search.isNotEmpty) {
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
