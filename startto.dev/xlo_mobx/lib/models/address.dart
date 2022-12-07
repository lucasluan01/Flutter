import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

class Address {
  Address({
    required this.cep,
    required this.city,
    required this.district,
    required this.uf,
  });

  UF uf;
  City city;
  String cep, district;

  @override
  String toString() {
    return """ Address {
      cep: $cep,
      city: $city,
      district: $district,
      uf: $uf,
    }
    """;
  }
}
