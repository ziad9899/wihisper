import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final String username;

  const ChatDetailScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add(text);
        _controller.clear();
      });
    }
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
          title: Text(widget.username, style: const TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: index.isEven ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? const Color(0xFF764ba2)
                            : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        messages[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        border: const Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.camera_alt, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.image, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.mic, color: Colors.white), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'اكتب رسالة...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
