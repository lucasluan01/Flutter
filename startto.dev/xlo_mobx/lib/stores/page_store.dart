//  flutter pub run build_runner watch

import 'package:mobx/mobx.dart';
part 'page_store.g.dart';

// ignore: library_private_types_in_public_api
class PageStore = _PageStoreBase with _$PageStore;

abstract class _PageStoreBase with Store {
  @observable
  int pageIndex = 0;

  @action
  void setPage(int value) => pageIndex = value;

}
