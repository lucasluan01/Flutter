import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    this.isShowAll = true,
    this.selected,
  });

  final Category? selected;
  final bool isShowAll;

  @override
  Widget build(BuildContext context) {
    final categoryStore = GetIt.instance<CategoryStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(32),
          child: Observer(
            builder: (_) {
              if (categoryStore.error != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(categoryStore.error!),
                      backgroundColor: Colors.red,
                    ),
                  );
                });
              }
              if (categoryStore.categories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final categories = isShowAll ? categoryStore.allCategoryList : categoryStore.categories;
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(
                  color: Colors.grey,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(category);
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      color: category.id == selected?.id ? Colors.purple.withAlpha(50) : null,
                      child: Text(
                        category.description!,
                        style: TextStyle(
                          fontWeight: category.id == selected?.id ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
