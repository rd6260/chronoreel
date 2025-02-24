import 'package:chronoreel/screens/search_screen.dart';
import 'package:chronoreel/utils/data/test_show_data.dart';
import 'package:chronoreel/widgets/show_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'My Library',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [Icon(Icons.more_vert)],
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.50, // Adjusted for more height
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: shows.length,
        itemBuilder: (context, index) {
          final show = shows[index];
          return ShowCard(show: show);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        },
      ),
    );
  }
}
