import 'dart:math';
import 'package:flutter/material.dart';
import 'post_model.dart';

/// نموذج مبسّط لِـــردّ واحد (وهمي حالياً)
class Reply {
  final String id;
  final String content;
  final DateTime timestamp;
  final int distance; // بالمتر تقريباً
  int likes;

  Reply({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.distance,
    this.likes = 0,
  });

  String timeAgo() {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inSeconds < 60) return 'الآن';
    if (diff.inMinutes < 60) return '${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return '${diff.inHours} ساعة';
    return '${diff.inDays} يوم';
  }

  String distanceText() {
    if (distance < 100) return 'قريب';
    if (distance < 500) return 'متوسط';
    return 'بعيد';
  }
}

class PostDetailScreen extends StatefulWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _replyController = TextEditingController();

  final List<Reply> _replies = [
    // بيانات تجريبية
    Reply(
      id: 'r1',
      content: 'جرب مطعم الفطور الشعبي جنب المسجد 👍',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      distance: 120,
      likes: 4,
    ),
    Reply(
      id: 'r2',
      content: 'عن نفسي أنصحك بـ Café Bliss، أكلهم لذيذ ☕️🥐',
      timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
      distance: 60,
      likes: 2,
    ),
  ];

  void _addReply() {
    final text = _replyController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _replies.insert(
        0,
        Reply(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          content: text,
          timestamp: DateTime.now(),
          distance: Random().nextInt(800) + 50,
        ),
      );
      _replyController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.post.userNumber,
              style: const TextStyle(color: Colors.white)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              tooltip: 'مشاركة الرابط',
              icon: const Icon(Icons.link),
              onPressed: () {
                // TODO: دمج مشاركة الرابط
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // ---------- بطاقة المنشور الأصلي ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.post.content,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.favorite,
                            color: Colors.pinkAccent, size: 18),
                        const SizedBox(width: 4),
                        Text('${widget.post.likes}',
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 12),
                        const Icon(Icons.comment,
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 4),
                        Text('${widget.post.comments}',
                            style: const TextStyle(color: Colors.white)),
                        const Spacer(),
                        Text(widget.post.timeAgo(),
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12)),
                        const SizedBox(width: 6),
                        Text(widget.post.distanceText(),
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),
            // ---------- قائمة الردود ----------
            Expanded(
              child: _replies.isEmpty
                  ? const Center(
                  child: Text('لا توجد ردود بعد',
                      style: TextStyle(color: Colors.white54)))
                  : ListView.builder(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                reverse: false,
                itemCount: _replies.length,
                itemBuilder: (context, index) {
                  final r = _replies[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.content,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.favorite,
                                size: 18, color: Colors.pinkAccent),
                            const SizedBox(width: 4),
                            Text('${r.likes}',
                                style:
                                const TextStyle(color: Colors.white)),
                            const Spacer(),
                            Text(r.timeAgo(),
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 12)),
                            const SizedBox(width: 6),
                            Text(r.distanceText(),
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // ---------- شريط كتابة الرد ----------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.25),
                border: const Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  IconButton(
                      tooltip: 'كاميرا',
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {
                        // TODO: إضافة التقاط صورة
                      }),
                  IconButton(
                      tooltip: 'معرض',
                      icon:
                      const Icon(Icons.photo_library, color: Colors.white),
                      onPressed: () {
                        // TODO: اختيار صورة من المعرض
                      }),
                  IconButton(
                      tooltip: 'صوت',
                      icon: const Icon(Icons.mic, color: Colors.white),
                      onPressed: () {
                        // TODO: تسجيل وإرسال مقطع صوتي
                      }),
                  Expanded(
                    child: TextField(
                      controller: _replyController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'اكتب ردك هنا...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      minLines: 1,
                      maxLines: 3,
                    ),
                  ),
                  IconButton(
                    tooltip: 'إرسال',
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _addReply,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
