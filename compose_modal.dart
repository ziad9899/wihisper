import 'dart:ui';
import 'package:flutter/material.dart';

class ComposeModal extends StatefulWidget {
  final Function(String) onPost;

  const ComposeModal({
    Key? key,
    required this.onPost,
  }) : super(key: key);

  @override
  _ComposeModalState createState() => _ComposeModalState();
}

class _ComposeModalState extends State<ComposeModal>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _handlePost() {
    final content = _textController.text.trim();
    if (content.isNotEmpty) {
      widget.onPost(content);
      _closeModal();
    }
  }

  void _closeModal() {
    _animationController.reverse().then((_) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5 * _fadeAnimation.value),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Transform.translate(
                  offset: Offset(0, 400 * _slideAnimation.value),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1a1a1a),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildHandle(),
                        _buildHeader(),
                        Expanded(child: _buildContent(scrollController)),
                        _buildFooter(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'منشور جديد',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: _closeModal,
            icon: Icon(
              Icons.close,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ScrollController scrollController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'شارك أفكارك مع الجيران...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: 'اكتب منشورك هنا...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildMediaButton(
                icon: Icons.camera_alt,
                label: 'كاميرا',
                onTap: () {
                  // TODO: إضافة ربط الكاميرا لاحقًا
                },
              ),
              SizedBox(width: 16),
              _buildMediaButton(
                icon: Icons.photo_library,
                label: 'معرض الصور',
                onTap: () {
                  // TODO: إضافة ربط المعرض لاحقًا
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMediaButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white.withOpacity(0.7),
              size: 16,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'سيظهر منشورك للأشخاص القريبين منك',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
          ElevatedButton(
            onPressed: _handlePost,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFff6b6b),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'نشر',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
