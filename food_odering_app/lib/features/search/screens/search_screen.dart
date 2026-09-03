import 'package:flutter/material.dart';

/// Search screen placeholder - actual search functionality is in search_tab.dart
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: const Center(child: Text('Search Screen - Coming Soon')),
    );
  }
}
