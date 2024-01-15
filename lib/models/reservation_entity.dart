class ReservationEntity {
  final String id;
  final String restaurantName;
  final String restaurantPicture;
  final int guestsNum;
  final String pickDate;
  final String pickTime;
  final String status;

  ReservationEntity({
    required this.id,
    required this.restaurantName,
    required this.restaurantPicture,
    required this.guestsNum,
    required this.pickDate,
    required this.pickTime,
     String? status,
  }) : status = status ?? 'Reserved';

  @override
  String toString() {
    return 'reservationd id: $id, restaurant name: $restaurantName, guests num: $guestsNum, date: $pickDate, time: $pickTime, status: $status';
  }
}
