// 📄 post_model.dart

class Post {
  final String id;
  final String userNumber;
  final String content;
  final DateTime timestamp;
  final int distance;
  int likes;
  int comments;

  Post({
    required this.id,
    required this.userNumber,
    required this.content,
    required this.timestamp,
    required this.distance,
    required this.likes,
    required this.comments,
  });

  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) return 'الآن';
    if (difference.inMinutes < 60) return '${difference.inMinutes} دقيقة';
    if (difference.inHours < 24) return '${difference.inHours} ساعة';
    return '${difference.inDays} يوم';
  }

  String distanceText() {
    if (distance < 100) return 'قريب';
    if (distance < 500) return 'متوسط';
    return 'بعيد';
  }
}
