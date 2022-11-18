import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder<List>(
      future: suggestions(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                snapshot.data![index],
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              leading: const Icon(
                Icons.play_arrow,
                color: Colors.white70,
              ),
              onTap: () {
                close(context, snapshot.data![index]);
              },
            );
          },
        );
      },
    );
  }

  Future<List> suggestions(String search) async {
    var response = await http.get(
      Uri.parse(
          "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"),
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      jsonResponse = jsonResponse[1].map((item) => item[0]).toList();

      return jsonResponse;
    } else {
      throw Exception("Request failed with status: ${response.statusCode}.");
    }
  }
}
