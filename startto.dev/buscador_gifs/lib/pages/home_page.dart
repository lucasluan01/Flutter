import 'dart:async';

import 'package:buscador_gifs/repositories/gifs_repository.dart';
import 'package:buscador_gifs/widgets/grid_view_gifs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  final GifsRepository _gifsRepository = GifsRepository();
  String? _search;
  late Timer timer;
  int page = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
          'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search GIFs',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
                onChanged: (value) async {
                  timer = Timer(const Duration(seconds: 3), () {
                    setState(() {
                      _search = searchController.text.isEmpty ? null : searchController.text;
                      page = 0;
                    });
                  });
                },
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: _gifsRepository.getGifs(search: _search, page: page),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    }

                    return GridViewGifs(
                      search: _search,
                      buildContext: context,
                      asyncSnapshot: snapshot,
                      onMoreGifs: moreGifs,
                    );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  void moreGifs() {
    setState(() {
      page++;
    });
  }
}
