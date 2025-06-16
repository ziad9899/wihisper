// 📄 home_screen.dart (النسخة الأصلية المطلوبة)
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'post_model.dart';
import 'post_card.dart';
import 'compose_modal.dart';
import 'post_detail_screen.dart';
import 'search_screen.dart';
import 'messages_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Post> posts = [];
  String userNumber = '';
  String userLocation = 'جارٍ تحديد الموقع...';

  @override
  void initState() {
    super.initState();
    _initUser();
    _loadInitialPosts();
    _getCurrentLocation();
  }

  Future<void> _initUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedId = prefs.getString('user_id');
    if (storedId == null) {
      storedId = '#${1000 + Random().nextInt(9000)}';
      await prefs.setString('user_id', storedId);
    }
    setState(() {
      userNumber = storedId!;
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    final place = placemarks.first;
    setState(() {
      userLocation = '${place.locality ?? ''} - ${place.subLocality ?? place.street ?? ''}';
    });
  }

  void _loadInitialPosts() {
    setState(() {
      posts = [
        Post(
          id: '1',
          userNumber: '#2843',
          content: 'مرحباً بالجيران! هل يعرف أحد مطعم جيد للإفطار في المنطقة؟ 🍳',
          timestamp: DateTime.now().subtract(Duration(minutes: 2)),
          distance: 80,
          likes: 12,
          comments: 3,
        ),
        Post(
          id: '2',
          userNumber: '#5691',
          content: 'يا جماعة، ممكن أحد يساعدني؟ سيارتي معطلة قدام البنك 🚗💔',
          timestamp: DateTime.now().subtract(Duration(minutes: 5)),
          distance: 250,
          likes: 8,
          comments: 5,
        ),
        Post(
          id: '3',
          userNumber: '#3174',
          content: 'بيع: آيفون 14 حالة ممتازة، السعر قابل للتفاوض 📱✨',
          timestamp: DateTime.now().subtract(Duration(minutes: 10)),
          distance: 800,
          likes: 15,
          comments: 7,
        ),
        Post(
          id: '4',
          userNumber: '#8529',
          content: 'لقيت قطة صغيرة ضائعة، إذا أحد يدور عنها يتواصل معي 🐱💕',
          timestamp: DateTime.now().subtract(Duration(minutes: 15)),
          distance: 320,
          likes: 22,
          comments: 4,
        ),
      ];
    });
  }

  void _addNewPost(String content) {
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userNumber: userNumber,
      content: content,
      timestamp: DateTime.now(),
      distance: Random().nextInt(500) + 50,
      likes: 0,
      comments: 0,
    );

    setState(() {
      posts.insert(0, newPost);
    });
  }

  void _showComposeModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ComposeModal(
        onPost: _addNewPost,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showComposeModal,
        child: Icon(Icons.edit, color: Colors.white),
        backgroundColor: Color(0xFFff6b6b),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Text(userLocation, style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFff6b6b), Color(0xFFfeca57)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              userNumber,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return SearchScreen(userLocation: userLocation, userNumber: userNumber);
      case 2:
        return MessagesScreen(userNumber: userNumber);
      case 3:
        return NotificationsScreen(userLocation: userLocation);
      default:
        return SettingsScreen(userNumber: userNumber);
    }
  }

  Widget _buildHomePage() {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(
          post: posts[index],
          onLike: () => setState(() => posts[index].likes++),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PostDetailScreen(post: posts[index])),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Color(0xFFfeca57),
        unselectedItemColor: Colors.white.withOpacity(0.6),
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'الإشعارات'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}
