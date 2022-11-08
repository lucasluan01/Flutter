import 'dart:math';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:agenda_contatos/models/contact_model.dart';
import 'package:agenda_contatos/pages/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { orderAz, orderZa }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper contactHelper = ContactHelper();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();

    getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contatos",
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderAz,
                child: Text('Ordenar de A-Z'),
              ),
              const PopupMenuItem<OrderOptions>(
                value: OrderOptions.orderZa,
                child: Text('Ordenar de Z-A'),
              ),
            ],
            onSelected: orderList,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showContactPage();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
          height: 1,
        ),
        padding: const EdgeInsets.all(16),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            title: Text(
              contacts[index].name!,
            ),
            subtitle: Text(contacts[index].phone!),
            leading: SizedBox(
              height: 40,
              width: 40,
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1),
                child: Text(contacts[index].name![0].toUpperCase()),
              ),
            ),
            onTap: () {
              showOptions(context, index);
            },
          );
        },
      ),
    );
  }

  void getAllContacts() {
    contactHelper.getAllContacts().then((response) {
      setState(() {
        contacts = response;
        orderList(OrderOptions.orderAz);
      });
    });
  }

  void showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            launchUrl(
                              Uri(
                                scheme: 'tel',
                                path: '${contacts[index].phone}',
                              ),
                            );
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Ligar",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showContactPage(contact: contacts[index]);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Editar",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            contactHelper.deleteContact(contacts[index].id!);
                            setState(() {
                              contacts.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Excluir",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showContactPage({Contact? contact}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contact: contact,
        ),
      ),
    );

    if (recContact != null) {
      if (contact != null) {
        await contactHelper.updateContact(recContact);
      } else {
        await contactHelper.saveContact(recContact);
      }
      getAllContacts();
    }
  }

  void orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderAz:
        contacts.sort(((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase())));
        break;
      case OrderOptions.orderZa:
        contacts.sort(((a, b) => b.name!.toLowerCase().compareTo(a.name!.toLowerCase())));
        break;
      default:
        break;
    }
    setState(() {});
  }
}
