import 'reservation_entity.dart';

class UserEntity {
  final String id;
  String fullName;
  String contact;
  String picture;
  String email;
  String password;
  final List<ReservationEntity> reservations;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.contact,
    required this.email,
    String? picture,
    required this.password,
    List<ReservationEntity>? reservations,
  })  : picture = picture ?? 'default_user.png',
        reservations = reservations ?? [];

  @override
  String toString() {
    return 'id: $id, full name: $fullName, picture: $picture contact: $contact, email: $email, password: $password';
  }
}
