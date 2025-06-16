// 📄 settings_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final String userNumber;
  const SettingsScreen({super.key, required this.userNumber});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool privateChatEnabled = true;

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Text(title, style: TextStyle(color: Colors.white70, fontSize: 16)),
        ),
        ...children,
        const Divider(color: Colors.white24, height: 1),
      ],
    );
  }

  Widget _buildTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
      trailing: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white54, size: 16),
    );
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
          title: const Text('الإعدادات', style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            _buildSection('عام', [
              _buildTile('أحب ويسبر ❤️', Icons.favorite, () {
                _launchURL("https://apps.apple.com/" /* رابط آبل ستور */);
              }),
              _buildTile('الموقع', Icons.location_on, () {}),
              _buildTile('الحساب', Icons.person, () {}),
              SwitchListTile.adaptive(
                title: const Text('طلب محادثة خاصة', style: TextStyle(color: Colors.white)),
                value: privateChatEnabled,
                onChanged: (value) {
                  setState(() => privateChatEnabled = value);
                },
                secondary: const Icon(Icons.lock, color: Colors.white),
              )
            ]),

            _buildSection('المجتمع', [
              _buildTile('الإرشادات العامة', Icons.menu_book, () {}),
              _buildTile('الإشراف', Icons.verified_user, () {}),
              _buildTile('قيم المجتمع', Icons.thumb_up, () {}),
            ]),

            _buildSection('الدعم', [
              _buildTile('مركز الدعم', Icons.help_outline, () {}),
              _buildTile('تحدث معنا', Icons.edit, () {}),
            ]),

            _buildSection('آخر', [
              _buildTile('أعلن في ويسبر 🎯', Icons.campaign, () {}),
              _buildTile('سياسة المستخدم 📜', Icons.rule, () {}),
              _buildTile('سياسة الخصوصية 🔐', Icons.privacy_tip, () {}),
              _buildTile('حذف الحساب 😥', Icons.delete_forever, () {}),
            ])
          ],
        ),
      ),
    );
  }
}
