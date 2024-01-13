class UserEntity {
  final String? id;
  final String fullName;
  final String contact;
  final String? picture;
  final String email;
  final String password;

  UserEntity({
    this.id,
    required this.fullName,
    required this.contact,
    required this.email,
    this.picture,
    required this.password,
  });

  @override
  String toString() {
    return 'id: $id, full name: $fullName, picture: $picture contact: $contact, email: $email, password: $password';
  }
}
