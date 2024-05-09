import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cheers'),
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search cocktail',
              ),
            ),
          ],
        ),
      )
    );
  }
}
