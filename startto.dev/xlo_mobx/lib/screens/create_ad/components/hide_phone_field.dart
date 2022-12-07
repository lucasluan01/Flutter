import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/create_ad_store.dart';

class HidePhoneField extends StatelessWidget {
  const HidePhoneField({
    super.key,
    required this.createAdStore,
  });

  final CreateAdStore createAdStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Observer(
            builder: (_) {
              return Checkbox(
                value: createAdStore.hidePhone,
                onChanged: createAdStore.setHidePhone,
                activeColor: Theme.of(context).primaryColor,
              );
            },
          ),
          const Expanded(
            child: Text(
              "Ocultar o meu telefone neste anúncio",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
