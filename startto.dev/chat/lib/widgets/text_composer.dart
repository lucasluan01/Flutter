import 'package:chat/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextComposer extends StatefulWidget {
  const TextComposer({
    super.key,
    this.sendMessage,
    this.imageFile,
  });

  final Function({
    String message,
    XFile imageFile,
  })? sendMessage;
  final XFile? imageFile;

  @override
  State<TextComposer> createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {
  TextEditingController messageController = TextEditingController();
  bool isComposing = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () async {
              final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);

              if (imageFile == null) return;

              FirebaseRepository.sendMessage(imageFile: imageFile);
            },
            icon: const Icon(Icons.camera_alt),
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Mensagem",
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.all(12),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isComposing = value.trim().isNotEmpty;
                });
              },
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 8,
            ),
          ),
          if (isComposing) ...[
            const SizedBox(
              width: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  widget.sendMessage!(message: messageController.text);
                  messageController.clear();
                  setState(() {
                    isComposing = false;
                  });
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
          const SizedBox(),
        ],
      ),
    );
  }
}
