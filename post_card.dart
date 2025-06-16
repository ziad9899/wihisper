// 📄 post_card.dart
import 'package:flutter/material.dart';
import 'post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final VoidCallback onTap;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  post.userNumber,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(width: 10),
                Text(
                  post.distanceText(),
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              post.content,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.pinkAccent),
                  onPressed: onLike,
                ),
                Text(
                  '${post.likes}',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.comment, color: Colors.white70),
                const SizedBox(width: 4),
                Text(
                  '${post.comments}',
                  style: const TextStyle(color: Colors.white),
                ),
                const Spacer(),
                Text(
                  post.timeAgo(), // ✅ حل المشكلة هنا
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
