// points_page.dart
import 'package:flutter/material.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Points'),
      ),
      body: const Center(
        child: Text('This is the Points Page'),
      ),
    );
  }
}
