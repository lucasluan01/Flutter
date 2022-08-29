import 'package:flutter/material.dart';

class WebAppBarResponsive extends StatelessWidget {
  const WebAppBarResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // print('biggest ${constraints.biggest} \t smallest ${constraints.smallest}');
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(
                      color: Colors.grey[600]!,
                    ),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                        color: Colors.grey[500],
                      ),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pesquise por um curso',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (constraints.maxWidth >= 400) ...[
                const SizedBox(width: 32),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Aprender',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              if (constraints.maxWidth >= 500) ...[
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Flutter',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
