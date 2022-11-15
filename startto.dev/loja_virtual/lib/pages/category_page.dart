import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/data/product_data.dart';
import 'package:loja_virtual/widgets/cart_button.dart';
import 'package:loja_virtual/widgets/product_grid.dart';
import 'package:loja_virtual/widgets/product_tile.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    super.key,
    required this.snapshot,
  });

  final DocumentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: const CartButton(),
        appBar: AppBar(
          title: Text(snapshot.get("title")),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Grade",
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                text: "Lista",
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection("products").doc(snapshot.id).collection("items").get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return TabBarView(
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 305,
                  ),
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    ProductData productData = ProductData.fromDocument(snapshot.data!.docs[index]);
                    productData.category = this.snapshot.id;
                    return ProductGrid(
                      product: productData,
                    );
                  },
                ),
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                    height: 8,
                  ),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    ProductData productData = ProductData.fromDocument(snapshot.data!.docs[index]);
                    productData.category = this.snapshot.id;
                    return ProductTile(
                      product: productData,
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
