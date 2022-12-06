import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
part 'create_ad_store.g.dart';

// ignore: library_private_types_in_public_api
class CreateAdStore = _CreateAdStoreBase with _$CreateAdStore;

abstract class _CreateAdStoreBase with Store {
  ObservableList images = ObservableList();

  @observable
  Category? category;

  @action
  void setCategory(Category value) => category = value;
}
