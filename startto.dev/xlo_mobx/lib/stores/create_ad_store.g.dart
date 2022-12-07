// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ad_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateAdStore on _CreateAdStoreBase, Store {
  Computed<Address?>? _$addressComputed;

  @override
  Address? get address =>
      (_$addressComputed ??= Computed<Address?>(() => super.address,
              name: '_CreateAdStoreBase.address'))
          .value;
  Computed<bool>? _$imagesValidComputed;

  @override
  bool get imagesValid =>
      (_$imagesValidComputed ??= Computed<bool>(() => super.imagesValid,
              name: '_CreateAdStoreBase.imagesValid'))
          .value;
  Computed<bool>? _$titleValidComputed;

  @override
  bool get titleValid =>
      (_$titleValidComputed ??= Computed<bool>(() => super.titleValid,
              name: '_CreateAdStoreBase.titleValid'))
          .value;
  Computed<bool>? _$descriptionValidComputed;

  @override
  bool get descriptionValid => (_$descriptionValidComputed ??= Computed<bool>(
          () => super.descriptionValid,
          name: '_CreateAdStoreBase.descriptionValid'))
      .value;
  Computed<bool>? _$categoryValidComputed;

  @override
  bool get categoryValid =>
      (_$categoryValidComputed ??= Computed<bool>(() => super.categoryValid,
              name: '_CreateAdStoreBase.categoryValid'))
          .value;
  Computed<bool>? _$addressValidComputed;

  @override
  bool get addressValid =>
      (_$addressValidComputed ??= Computed<bool>(() => super.addressValid,
              name: '_CreateAdStoreBase.addressValid'))
          .value;
  Computed<bool>? _$priceValidComputed;

  @override
  bool get priceValid =>
      (_$priceValidComputed ??= Computed<bool>(() => super.priceValid,
              name: '_CreateAdStoreBase.priceValid'))
          .value;
  Computed<bool>? _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_CreateAdStoreBase.formValid'))
          .value;
  Computed<String?>? _$imagesErrorComputed;

  @override
  String? get imagesError =>
      (_$imagesErrorComputed ??= Computed<String?>(() => super.imagesError,
              name: '_CreateAdStoreBase.imagesError'))
          .value;
  Computed<String?>? _$categoryErrorComputed;

  @override
  String? get categoryError =>
      (_$categoryErrorComputed ??= Computed<String?>(() => super.categoryError,
              name: '_CreateAdStoreBase.categoryError'))
          .value;
  Computed<String?>? _$priceErrorComputed;

  @override
  String? get priceError =>
      (_$priceErrorComputed ??= Computed<String?>(() => super.priceError,
              name: '_CreateAdStoreBase.priceError'))
          .value;
  Computed<String?>? _$addressErrorComputed;

  @override
  String? get addressError =>
      (_$addressErrorComputed ??= Computed<String?>(() => super.addressError,
              name: '_CreateAdStoreBase.addressError'))
          .value;
  Computed<String?>? _$titleErrorComputed;

  @override
  String? get titleError =>
      (_$titleErrorComputed ??= Computed<String?>(() => super.titleError,
              name: '_CreateAdStoreBase.titleError'))
          .value;
  Computed<String?>? _$descriptionErrorComputed;

  @override
  String? get descriptionError => (_$descriptionErrorComputed ??=
          Computed<String?>(() => super.descriptionError,
              name: '_CreateAdStoreBase.descriptionError'))
      .value;
  Computed<dynamic>? _$sendPressedComputed;

  @override
  dynamic get sendPressed =>
      (_$sendPressedComputed ??= Computed<dynamic>(() => super.sendPressed,
              name: '_CreateAdStoreBase.sendPressed'))
          .value;

  late final _$categoryAtom =
      Atom(name: '_CreateAdStoreBase.category', context: context);

  @override
  Category? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Category? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$hidePhoneAtom =
      Atom(name: '_CreateAdStoreBase.hidePhone', context: context);

  @override
  bool get hidePhone {
    _$hidePhoneAtom.reportRead();
    return super.hidePhone;
  }

  @override
  set hidePhone(bool value) {
    _$hidePhoneAtom.reportWrite(value, super.hidePhone, () {
      super.hidePhone = value;
    });
  }

  late final _$titleAtom =
      Atom(name: '_CreateAdStoreBase.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_CreateAdStoreBase.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$priceTextAtom =
      Atom(name: '_CreateAdStoreBase.priceText', context: context);

  @override
  String get priceText {
    _$priceTextAtom.reportRead();
    return super.priceText;
  }

  @override
  set priceText(String value) {
    _$priceTextAtom.reportWrite(value, super.priceText, () {
      super.priceText = value;
    });
  }

  late final _$_CreateAdStoreBaseActionController =
      ActionController(name: '_CreateAdStoreBase', context: context);

  @override
  void setCategory(Category value) {
    final _$actionInfo = _$_CreateAdStoreBaseActionController.startAction(
        name: '_CreateAdStoreBase.setCategory');
    try {
      return super.setCategory(value);
    } finally {
      _$_CreateAdStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHidePhone(bool? value) {
    final _$actionInfo = _$_CreateAdStoreBaseActionController.startAction(
        name: '_CreateAdStoreBase.setHidePhone');
    try {
      return super.setHidePhone(value);
    } finally {
      _$_CreateAdStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_CreateAdStoreBaseActionController.startAction(
        name: '_CreateAdStoreBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_CreateAdStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$_CreateAdStoreBaseActionController.startAction(
        name: '_CreateAdStoreBase.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_CreateAdStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrice(String value) {
    final _$actionInfo = _$_CreateAdStoreBaseActionController.startAction(
        name: '_CreateAdStoreBase.setPrice');
    try {
      return super.setPrice(value);
    } finally {
      _$_CreateAdStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
category: ${category},
hidePhone: ${hidePhone},
title: ${title},
description: ${description},
priceText: ${priceText},
address: ${address},
imagesValid: ${imagesValid},
titleValid: ${titleValid},
descriptionValid: ${descriptionValid},
categoryValid: ${categoryValid},
addressValid: ${addressValid},
priceValid: ${priceValid},
formValid: ${formValid},
imagesError: ${imagesError},
categoryError: ${categoryError},
priceError: ${priceError},
addressError: ${addressError},
titleError: ${titleError},
descriptionError: ${descriptionError},
sendPressed: ${sendPressed}
    ''';
  }
}
