import 'package:flutter/material.dart';

/// Menu screen placeholder - uses MenuTab from main screen
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: const Center(child: Text('Use bottom navigation to access Menu')),
    );
  }
}
