// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';

enum AdStatus { PEDING, ACTIVE, SOLD, DELETED }

class Ad {
  Ad({
    required this.images,
    required this.title,
    required this.description,
    required this.category,
    required this.address,
    required this.price,
    required this.hidePhone,
    required this.user,
    this.status = AdStatus.PEDING,
  });

  List images;
  String title, description;
  late String id;
  Category category;
  Address address;
  num price;
  bool hidePhone;
  AdStatus status;
  late DateTime createdAt;
  User user;
  late int views;
}
