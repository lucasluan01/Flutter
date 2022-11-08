import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:agenda_contatos/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({
    super.key,
    this.contact,
  });

  final Contact? contact;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ContactHelper contactHelper = ContactHelper();

  late Contact editedContact;
  bool isUserEditted = false;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      editedContact = Contact();
    } else {
      editedContact = Contact.fromMap(widget.contact!.toMap());
      nameController.text = editedContact.name ?? "";
      emailController.text = editedContact.email ?? "";
      phoneController.text = editedContact.phone ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(editedContact.name ?? "Novo contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context, editedContact);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You must complete all required fields')),
              );
            }
          },
          child: const Icon(Icons.save),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Icon(
              Icons.account_circle,
              size: 120,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 32,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    onChanged: (value) {
                      isUserEditted = true;
                      editedContact.name = value.trim();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: emailController,
                    onChanged: (value) {
                      isUserEditted = true;
                      editedContact.email = value.trim();
                    },
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: phoneController,
                    onChanged: (value) {
                      isUserEditted = true;
                      editedContact.phone = value.trim();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (isUserEditted) {
      final shouldPop = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Descartar alterações?"),
            content: const Text("Se sair todas as alterações serão perdidas."),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Exit'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
      return shouldPop ?? false;
    }
    Navigator.pop(context);
    return false;
  }
}
