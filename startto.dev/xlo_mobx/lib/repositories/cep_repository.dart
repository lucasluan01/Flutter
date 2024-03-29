import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';

import '../models/address.dart';

class CepRepository {
  Future<Address> getAddressFromApi(String? cep) async {
    if (cep == null || cep.isEmpty) {
      return Future.error("CEP inválido");
    }

    final clearCep = cep.replaceAll(RegExp('[^0-9]'), "");

    if (clearCep.length != 8) {
      return Future.error("CEP inválido");
    }

    final endpoint = "https://viacep.com.br/ws/$clearCep/json";

    try {
      final response = await Dio().get<Map>(endpoint);

      if (response.data!.containsKey('erro') && response.data!["erro"]) {
        return Future.error("CEP não encontrado");
      }

      final ufList = await IbgeRepository().getUFList();

      return Address(
        cep: response.data!["cep"],
        city: City(name: response.data!["localidade"]),
        district: response.data!["bairro"],
        uf: ufList.firstWhere((uf) => uf.initials == response.data!["uf"]),
      );
    } catch (e) {
      return Future.error("Falha ao buscar CEP");
    }
  }
}
