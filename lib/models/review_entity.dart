class ReviewEntity {
  final String reviewId;
  final String text;
  final String userId;
  final String userName;
  final String userPicture;

  ReviewEntity({
    required this.reviewId,
    required this.text,
    required this.userId,
    required this.userName,
    required this.userPicture,
  });

  @override
  String toString() {
    return 'ReviewId; $reviewId, text: $text, userId: $userId, userName: $userName, userPicture: $userPicture';
  }
}
