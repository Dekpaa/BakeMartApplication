import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_page.dart';

class TutorialPage1 extends StatelessWidget {
  const TutorialPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color(0xFFFBC02D),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              height: 28,
            ),
            const SizedBox(width: 8),
            const Text(
              'BAKEMART',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: const TutorialContent(),
    );
  }
}

class TutorialContent extends StatelessWidget {
  const TutorialContent({super.key});

  final Map<String, List<Map<String, String>>> categorizedTutorials = const {
    'Beginner': [
      {
        'title': 'The Best Chocolate Cake Recipe',
        'url': 'https://www.youtube.com/watch?v=vI5w-fK25w4',
      },
      {
        'title': 'Easy Vanilla Cupcake Recipe',
        'url': 'https://www.youtube.com/watch?v=uU7eOlSL6Hk',
      },
    ],
    'Intermediate': [
      {
        'title': 'Beginners Guide To Baking BREAD At Home | Step By Step EXPLAINED',
        'url': 'https://www.youtube.com/watch?v=I4nEWk9udKQ',
      },
      {
        'title': 'BEST Red Velvet Cake (Very Soft, Moist & EASY!)',
        'url': 'https://www.youtube.com/watch?v=KvlAjbfv20M',
      },
    ],
    'Advanced': [
      {
        'title': 'Cupcake Decorating 101: How to Decorate Cupcakes',
        'url': 'https://www.youtube.com/watch?v=tOrmaNPOaRA',
      },
      {
        'title': 'How I make croissants from scratch | Easy version',
        'url': 'https://www.youtube.com/watch?v=Qy18mehuJPQ',
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
    return ListView(
      children: [
        const SizedBox(height: 8),
        const Center(
          child: Text(
            'My Tutorial',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ...categorizedTutorials.entries.map((entry) {
          final level = entry.key;
          final tutorials = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: ListTile(
                      title: Text(
                        tutorial['title']!,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.play_circle_fill,
                          color: Colors.black),
                      onTap: () => _launchURL(tutorial['url']!),
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );
  }
}
