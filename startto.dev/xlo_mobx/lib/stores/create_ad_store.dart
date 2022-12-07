import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';
part 'create_ad_store.g.dart';

// ignore: library_private_types_in_public_api
class CreateAdStore = _CreateAdStoreBase with _$CreateAdStore;

abstract class _CreateAdStoreBase with Store {
  CepStore cepStore = CepStore();

  ObservableList images = ObservableList();

  @observable
  Category? category;

  @observable
  bool hidePhone = false;

  @observable
  String title = "";

  @observable
  String description = "";

  @observable
  String priceText = "";

  @action
  void setCategory(Category value) => category = value;

  @action
  void setHidePhone(bool? value) => hidePhone = value!;

  @action
  void setTitle(String value) => title = value;

  @action
  void setDescription(String value) => description = value;

  @action
  void setPrice(String value) => priceText = value;

  @computed
  Address? get address => cepStore.address;

  @computed
  bool get imagesValid => images.isNotEmpty;

  @computed
  bool get titleValid => title.length >= 6;

  @computed
  bool get descriptionValid => description.length >= 10;

  @computed
  bool get categoryValid => category != null;

  @computed
  bool get addressValid => address != null;

  @computed
  bool get priceValid => priceText.isNotEmpty;

  @computed
  bool get formValid => imagesValid && titleValid && descriptionValid && categoryValid && addressValid && priceValid;

  @computed
  String? get imagesError => imagesValid ? null : "Insira pelo menos uma imagem";

  @computed
  String? get categoryError => category == null ? "Campo obrigatório" : null;

  @computed
  String? get priceError => priceText.isEmpty ? "Campo obrigatório" : null;

  @computed
  String? get addressError {
    if (cepStore.cep.isEmpty) {
      return "Campo Obrigatório";
    }

    if (cepStore.cep.length != 8) {
      return "O CEP deve conter 8 caracteres";
    }
    return null;
  }

  @computed
  String? get titleError {
    if (title.isEmpty) {
      return "Campo obrigatório";
    }

    if (title.length < 6) {
      return "O título deve conter pelo menos 6 caracteres";
    }

    return null;
  }

  @computed
  String? get descriptionError {
    if (description.isEmpty) {
      return "Campo obrigatório";
    }
    if (description.length < 10) {
      return "O campo deve conter pelo menos 10 caracteres";
    }
    return null;
  }

  @computed
  get sendPressed => formValid ? _send : null;

  void _send() {
    final ad = Ad(
      images: images,
      title: title,
      description: description,
      category: category!,
      address: address!,
      price: num.parse(priceText),
      hidePhone: hidePhone,
      user: GetIt.instance<UserManagerStore>().user!,
    );

    AdRepository().save(ad);
  }
}
