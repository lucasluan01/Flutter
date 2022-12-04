import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
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
                    TextField(
                      // enabled: !loginStore.isLoading,
                      decoration: InputDecoration(
                        labelText: "Título",
                        border: const OutlineInputBorder(),
                        isDense: true,
                        // errorText: loginStore.emailError,
                        // suffixIcon: loginStore.emailError != null
                        //     ? const Icon(
                        //         Icons.error,
                        //         color: Colors.red,
                        //       )
                        //     : null,
                      ),
                      // onChanged: loginStore.setEmail,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      // enabled: !loginStore.isLoading,
                      decoration: InputDecoration(
                        labelText: "Descrição",
                        border: const OutlineInputBorder(),
                        isDense: true,
                        // errorText: loginStore.emailError,
                        // suffixIcon: loginStore.emailError != null
                        //     ? const Icon(
                        //         Icons.error,
                        //         color: Colors.red,
                        //       )
                        //     : null,
                      ),
                      maxLines: 4,
                      minLines: 1,
                      // onChanged: loginStore.setEmail,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      // enabled: !loginStore.isLoading,
                      decoration: InputDecoration(
                        labelText: "CEP",
                        border: const OutlineInputBorder(),
                        isDense: true,
                        // errorText: loginStore.emailError,
                        // suffixIcon: loginStore.emailError != null
                        //     ? const Icon(
                        //         Icons.error,
                        //         color: Colors.red,
                        //       )
                        //     : null,
                      ),
                      // onChanged: loginStore.setEmail,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      // enabled: !loginStore.isLoading,
                      decoration: InputDecoration(
                        labelText: "Preço",
                        border: const OutlineInputBorder(),
                        isDense: true,
                        prefixText: "R\$ ",
                        // errorText: loginStore.emailError,
                        // suffixIcon: loginStore.emailError != null
                        //     ? const Icon(
                        //         Icons.error,
                        //         color: Colors.red,
                        //       )
                        //     : null,
                      ),
                      keyboardType: TextInputType.number,
                      // onChanged: loginStore.setEmail,
                    ),
                    const SizedBox(height: 48),
                    SizedBox( 
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Enviar"),
                      ),
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
