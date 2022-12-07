class UF {
  UF({
    required this.id,
    required this.initials,
    required this.name,
  });

  String? initials, name;
  int id;

  factory UF.fromJson(Map<String, dynamic> json) => UF(
        id: json["id"],
        name: json["nome"],
        initials: json["sigla"],
      );

  @override
  String toString() {
    return """UF {
      id: $id,
      name: $name,
      initials: $initials
    }
    """;
  }
}
