import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final String userLocation;

  const NotificationsScreen({Key? key, required this.userLocation}) : super(key: key);

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
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    _NotificationItem(title: "تم الرد على منشورك", time: "قبل دقيقة"),
                    _NotificationItem(title: "تم حفظ منشورك", time: "قبل 5 دقائق"),
                    _NotificationItem(title: "تمت الإعجاب بمنشورك", time: "قبل 10 دقائق"),
                    _NotificationItem(title: "تم التعليق على منشورك", time: "قبل 30 دقيقة"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.location_on, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "الإشعارات",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const Icon(Icons.notifications, color: Colors.white),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String time;

  const _NotificationItem({required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
