import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/category_repository.dart';
part 'category_store.g.dart';

// ignore: library_private_types_in_public_api
class CategoryStore = _CategoryStoreBase with _$CategoryStore;

abstract class _CategoryStoreBase with Store {
  @observable
  String? error;

  @computed
  List<Category> get allCategoryList => List.from(categories)..insert(0, Category(id: "*", description: "Todas"));

  ObservableList<Category> categories = ObservableList<Category>();

  _CategoryStoreBase() {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryRepository().getList();
      setCategories(categories);
    } catch (e) {
      setError(e.toString());
    }
  }

  @action
  void setCategories(List<Category> value) {
    categories.clear();
    categories.addAll(value);
  }

  @action
  void setError(String value) => error = value;
}
