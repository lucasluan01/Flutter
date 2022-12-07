import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/repositories/cep_repository.dart';
part 'cep_store.g.dart';

// ignore: library_private_types_in_public_api
class CepStore = _CepStoreBase with _$CepStore;

abstract class _CepStoreBase with Store {
  _CepStoreBase() {
    autorun((_) {
      if (cep.isEmpty || cep.length != 8) {
        _reset();
        return;
      }
      _searchCep();
    });
  }

  @observable
  String cep = "";

  @observable
  String? error;

  @observable
  bool loading = false;

  @observable
  Address? address;

  @action
  void setCep(String value) => cep = value;

  Future<void> _searchCep() async {
    loading = true;
    try {
      address = await CepRepository().getAddressFromApi(cep);
      error = null;
    } catch (e) {
      error = e.toString();
      address = null;
    }
    loading = false;
  }

  _reset() {
    address = null;
    error = null;
  }
}
