import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildBodyBack() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo,
                Colors.blue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );

    return Stack(
      children: [
        buildBodyBack(),
        CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Novidade"),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot<Object?>>(
              future: FirebaseFirestore.instance.collection("home").orderBy("priority").get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                List<QueryDocumentSnapshot<Object?>> docs = snapshot.data!.docs;

                return SliverToBoxAdapter(
                  child: StaggeredGrid.count(crossAxisCount: 2, children: [
                    ...docs.map(
                      (doc) => StaggeredGridTile.count(
                        crossAxisCellCount: doc.get('xGrid'),
                        mainAxisCellCount: doc.get('yGrid'),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: doc.get('imageURL'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ]),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
