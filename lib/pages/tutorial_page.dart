import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_page.dart'; 

class TutorialPage extends StatelessWidget {
  final bool isFromDashboard;
  const TutorialPage({super.key, this.isFromDashboard = false});

  final Map<String, List<Map<String, String>>> categorizedTutorials = const {
    'Beginner': [
      {
        'title': 'How to Bake a Perfect Chocolate Cake',
        'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      },
      {
        'title': 'Easy Vanilla Cupcake Recipe',
        'url': 'https://www.youtube.com/watch?v=3U4kWz0DgI4',
      },
    ],
    'Intermediate': [
      {
        'title': 'Beginner’s Guide to Baking Bread',
        'url': 'https://www.youtube.com/watch?v=I4nEWk9udKQ',
      },
      {
        'title': 'Moist Red Velvet Cake',
        'url': 'https://www.youtube.com/watch?v=NdZ-0Wl_5WU',
      },
    ],
    'Advanced': [
      {
        'title': 'Decorating Cupcakes 101',
        'url': 'https://www.youtube.com/watch?v=2Fg_Jj1dPwM',
      },
      {
        'title': 'Making Croissants from Scratch',
        'url': 'https://www.youtube.com/watch?v=fUybZz5jzU4',
      },
    ],
  };

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Baking Tutorials",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFFBC02D),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          },
        ),
      ),
      body: ListView(
        children: categorizedTutorials.entries.map((entry) {
          final level = entry.key;
          final tutorials = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                    level,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ...tutorials.map((tutorial) {
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: ListTile(
                      title: Text(
                        tutorial['title']!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.play_circle_fill, color: Colors.black),
                      onTap: () => _launchURL(tutorial['url']!),
                    ),
                  );
                }),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
