// 📄 search_screen.dart
import 'dart:ui'; // ✅ حل المشكلة هنا
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String userNumber;
  final String userLocation;

  const SearchScreen({
    super.key,
    required this.userNumber,
    required this.userLocation,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> categories = [
    "حيوانات", "رجال ونساء", "حياة يومية", "فعاليات",
    "مسلسلات/أفلام", "استفسارات", "ملاحظاتكم"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              _buildSearchField(),
              _buildCategoryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    widget.userLocation,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFff6b6b), Color(0xFFfeca57)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            widget.userNumber,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'بحث في ${widget.userLocation}',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              categories[index],
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
