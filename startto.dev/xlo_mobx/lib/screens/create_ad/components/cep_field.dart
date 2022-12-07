import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/create_ad_store.dart';

class CepField extends StatelessWidget {
  CepField({
    super.key,
    required this.createAdStore,
  }) : cepStore = createAdStore.cepStore;

  final CreateAdStore createAdStore;
  final CepStore cepStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Observer(
          builder: (_) {
            return TextFormField(
              onChanged: cepStore.setCep,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: "CEP",
                border: const OutlineInputBorder(),
                errorText: createAdStore.addressError,
                suffixIcon: createAdStore.addressError != null
                    ? const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 18,
                      )
                    : null,
              ),
            );
          },
        ),
        Observer(builder: (_) {
          if (cepStore.address == null && cepStore.error == null && !cepStore.loading) {
            return Container();
          }
          if (cepStore.address == null && cepStore.error == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (cepStore.error != null) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.red.withAlpha(100),
              ),
              margin: const EdgeInsets.only(top: 4),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: Text(
                cepStore.error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          final a = cepStore.address;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.purple.withAlpha(100),
            ),
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              "${a!.district}, ${a.city.name} - ${a.uf.initials}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ],
    );
  }
}
