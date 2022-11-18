import 'dart:async';
import 'dart:ui';
import 'dart:convert' as convert;
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube/models/video.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};
  final _favoriteController = BehaviorSubject<Map<String, Video>>();

  Stream<Map<String, Video>> get outFavorite => _favoriteController.stream;

  FavoriteBloc() {
    SharedPreferences.getInstance().then(
      (prefs) {
        if (prefs.getKeys().contains("favorites")) {
          _favorites = convert.jsonDecode(prefs.getString("favorites")!).map((key, value) {
            return MapEntry(key, Video.fromJson(value));
          }).cast<String, Video>();

          _favoriteController.add(_favorites);
        }
      },
    );
  }

  void toggleFavorite(Video video) {
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    } else {
      _favorites[video.id!] = video;
    }
    _favoriteController.sink.add(_favorites);

    _saveFavorite();
  }

  void _saveFavorite() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("favorites", convert.jsonEncode(_favorites));
    });
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _favoriteController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
