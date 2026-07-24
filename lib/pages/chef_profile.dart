import 'package:flutter/material.dart';
import 'recipe_page.dart'; 

class ChefProfilePage extends StatelessWidget {
  final Map<String, dynamic> chefData;

  const ChefProfilePage({super.key, required this.chefData});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> recipes = chefData['recipes'];

    return Scaffold(
      appBar: AppBar(
        title: Text(chefData['name'], style: const TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFFBC02D),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(chefData['profileImage']),
              backgroundColor: const Color.fromARGB(255, 233, 223, 172),
            ),
            const SizedBox(height: 20),
            Text(
              chefData['name'],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                chefData['bio'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ),
            const Divider(thickness: 1),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Recipes by this Chef",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  color: const Color(0xFFFFF8E1),
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.amber.shade100),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipePage(recipe: recipe),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.asset(
                            recipe['image'],
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe['title'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                recipe['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.brown[300],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
