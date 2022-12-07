import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create_ad/components/category_field.dart';
import 'package:xlo_mobx/screens/create_ad/components/cep_field.dart';
import 'package:xlo_mobx/screens/create_ad/components/hide_phone_field.dart';
import 'package:xlo_mobx/screens/create_ad/components/images_field.dart';
import 'package:xlo_mobx/stores/create_ad_store.dart';

class CreateAdScreen extends StatelessWidget {
  const CreateAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createAdStore = CreateAdStore();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar anúncio"),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(32),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ImagesField(createStore: createAdStore),
                    const SizedBox(height: 16),
                    Observer(
                      builder: (_) {
                        return TextField(
                          // enabled: !loginStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "Título",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: createAdStore.titleError,
                            suffixIcon: createAdStore.titleError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          onChanged: createAdStore.setTitle,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Observer(
                      builder: (_) {
                        return TextField(
                          // enabled: !loginStore.isLoading,
                          decoration: InputDecoration(
                            labelText: "Descrição",
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: createAdStore.descriptionError,
                            suffixIcon: createAdStore.descriptionError != null
                                ? const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  )
                                : null,
                          ),
                          maxLines: 4,
                          minLines: 1,
                          onChanged: createAdStore.setDescription,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    CategoryField(createAdStore: createAdStore),
                    const SizedBox(height: 16),
                    CepField(createAdStore: createAdStore),
                    const SizedBox(height: 16),
                    Observer(builder: (_) {
                      return TextField(
                        // enabled: !loginStore.isLoading,
                        decoration: InputDecoration(
                          labelText: "Preço",
                          border: const OutlineInputBorder(),
                          isDense: true,
                          prefixText: "R\$ ",
                          errorText: createAdStore.priceError,
                          suffixIcon: createAdStore.priceError != null
                              ? const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                )
                              : null,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: createAdStore.setPrice,
                      );
                    }
                    ),
                    HidePhoneField(createAdStore: createAdStore),
                    const SizedBox(height: 16),
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: createAdStore.sendPressed,
                          child: const Text("Enviar"),
                        ),
                      );
                    }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
