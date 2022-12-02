// ignore_for_file: constant_identifier_names

enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  String? password, id;
  String name, email, phone;
  DateTime? createdAt;
  UserType type;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.createdAt,
    this.password,
    this.type = UserType.PARTICULAR,
  });

  @override
  String toString() {
    return "User { id: $id, name: $name, email: $email, phone: $phone, password: $password, createdAt: $createdAt, type: $type }";
  }
}
