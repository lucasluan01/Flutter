import 'dart:convert';
import 'package:http/http.dart' as http;

class GifsRepository {
  Future<Map> getGifs({
    String? search,
    int page = 0,
  }) async {
    Uri url;
    int limit = 19;

    if (search != null) {
      url = Uri.https('api.giphy.com', '/v1/gifs/search', {
        'api_key': '81yz81rwYBcN9pnp8jwXtjJ2Wa8YDxru',
        'q': search,
        'limit': '$limit',
        'rating': 'g',
        'lang': 'en',
        'offset': '${page * limit}',
      });
    } else {
      url = Uri.https('api.giphy.com', '/v1/gifs/trending', {
        'api_key': '81yz81rwYBcN9pnp8jwXtjJ2Wa8YDxru',
        'limit': '$limit',
        'rating': 'g',
        'offset': '${page * limit}',
      });
    }
    var response = await http.get(url);
    return json.decode(response.body);
  }
}
