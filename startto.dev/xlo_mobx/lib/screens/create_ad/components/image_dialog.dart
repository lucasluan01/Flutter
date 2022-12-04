import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({
    super.key,
    required this.image,
    required this.onDelete,
  });

  final dynamic image;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.file(image),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Remover imagem",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
