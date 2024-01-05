class UserEntity {
  final String? id;
  final String fullName;
  final String? contact;
  final String email;
  final String password;

  UserEntity({
    this.id,
    required this.fullName,
    this.contact,
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'id: $id, full name: $fullName, contact: $contact, email: $email, password: $password';
  }
}
