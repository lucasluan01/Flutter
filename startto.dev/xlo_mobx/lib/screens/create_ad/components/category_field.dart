import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/category_screen.dart';
import 'package:xlo_mobx/stores/create_ad_store.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({
    super.key,
    required this.createAdStore,
  });

  final CreateAdStore createAdStore;
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: createAdStore.categoryValid
                    ? Border.all(color: Colors.grey)
                    : Border.all(
                        color: Colors.red.shade700,
                        width: 2,
                      ),
              ),
              child: ListTile(
                title: Text(
                  "Categoria",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: createAdStore.category != null ? 12 : 18,
                  ),
                ),
                subtitle: createAdStore.category != null
                    ? Text(
                        createAdStore.category!.description!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      )
                    : null,
                trailing: const Icon(Icons.keyboard_arrow_down),
                onTap: () async {
                  final category = await showDialog(
                    context: context,
                    builder: (_) => CategoryScreen(
                      isShowAll: false,
                      selected: createAdStore.category,
                    ),
                  );

                  if (category != null) {
                    createAdStore.setCategory(category);
                  }
                },
              ),
            ),
            if (!createAdStore.categoryValid)
              Container(
                margin: const EdgeInsets.only(left: 14, top: 6),
                child: Text(
                  createAdStore.categoryError!,
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
