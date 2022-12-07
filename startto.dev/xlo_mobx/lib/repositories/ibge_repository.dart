import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:dio/dio.dart';

class IbgeRepository {
  Future<List<UF>> getUFList() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey("UF_LIST")) {
      final json = jsonDecode(preferences.getString("UF_LIST")!);
      return json.map<UF>((e) => UF.fromJson(e)).toList()
        ..sort((UF a, UF b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
    }

    const endpoint = "https://servicodados.ibge.gov.br/api/v1/localidades/estados";

    try {
      final response = await Dio().get<List>(endpoint);
      final ufList = response.data!.map<UF>((e) => UF.fromJson(e)).toList()
        ..sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));

      preferences.setString("UF_LIST", jsonEncode(response.data));

      return ufList;
    } on DioError {
      return Future.error("Falha ao obter lista de Estados");
    }
  }

  Future<List<City>> getCityListFromApi(UF uf) async {
    final endpoint = "https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios";

    try {
      final response = await Dio().get<List>(endpoint);
      final cityList = response.data!.map<City>((e) => City.fromJson(e)).toList()
        ..sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));

      return cityList;
    } on DioError {
      return Future.error("Falha ao obter lista de cidades");
    }
  }
}
