import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/create_ad/components/image_dialog.dart';
import 'package:xlo_mobx/screens/create_ad/components/image_source_modal.dart';
import 'package:xlo_mobx/stores/create_ad_store.dart';

class ImagesField extends StatelessWidget {
  const ImagesField({
    super.key,
    required this.createStore,
  });

  final CreateAdStore createStore;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      height: 120,
      child: Observer(builder: (_) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: createStore.images.length < 5 ? createStore.images.length + 1 : 5,
          itemBuilder: (_, index) {
            if (createStore.imagesError != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(createStore.imagesError!),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            }
            if (index == createStore.images.length) {
              return GestureDetector(
                onTap: () {
                  if (Platform.isAndroid) {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return ImageSourceModal(onImageSelected: onImageSelected);
                      },
                    );
                    return;
                  }
                  showCupertinoModalPopup(
                    context: context,
                    builder: (_) {
                      return ImageSourceModal(onImageSelected: onImageSelected);
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 36,
                  ),
                ),
              );
            }
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => ImageDialog(
                    image: createStore.images[index],
                    onDelete: () => createStore.images.removeAt(index),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(createStore.images[index]),
              ),
            );
          },
        );
      }),
    );
  }
}
