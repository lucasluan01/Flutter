import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          'https://picsum.photos/300/200',
        ),
        const SizedBox(height: 8),
        const Flexible(
          child: AutoSizeText(
            'Criação de Apps Android e iOS com Flutter - Crie 16 Apps',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Text(
          'Daniel Ciolfi',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        const Text(
          'R\$ 20,00',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
