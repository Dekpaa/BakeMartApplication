import 'package:flutter/material.dart';
import 'chef_profile.dart';

class ChefListPage extends StatelessWidget {
 const ChefListPage({super.key});

  static final List<Map<String, dynamic>> chefs = [
    {
      'name': 'Chef Anis',
      'bio': 'Founder of Anis Culinary Academy. Known for her cakes and pastries. Frequently appears in culinary magazines and shows.',
      'image': 'assets/images/chef_anis.jpg',
      'profileImage': 'assets/images/chef_anis.jpg',
      'recipes': [
        {
          'title': 'Red Velvet Cupcake',
          'description': 'Soft red velvet cupcakes with cream cheese frosting.',
          'image': 'assets/images/red_velvet.jpg',
          'ingredients': ['Flour', 'Cocoa powder', 'Red coloring', 'Cream cheese'],
          'instructions': ['Mix ingredients.', 'Bake and cool.', 'Frost with cream cheese.']
        },
        {
          'title': 'Mini Cheesecake',
          'description': 'Bite-sized creamy cheesecakes.',
          'image': 'assets/images/mini_cheesecake.jpg',
          'ingredients': ['Cream cheese', 'Sugar', 'Eggs', 'Crackers'],
          'instructions': ['Make crust.', 'Mix and pour batter.', 'Bake in muffin tin.']
        },
        {
          'title': 'Fruit Tart',
          'description': 'Tart shell with pastry cream and fresh fruits.',
          'image': 'assets/images/fruit_tart.jpg',
          'ingredients': ['Tart shell', 'Pastry cream', 'Fruits'],
          'instructions': ['Bake shell.', 'Fill with cream.', 'Top with fruits.']
        },
        {
          'title': 'Chocolate Éclair',
          'description': 'Choux pastry filled with cream and topped with chocolate.',
          'image': 'assets/images/eclair.jpg',
          'ingredients': ['Butter', 'Flour', 'Eggs', 'Chocolate'],
          'instructions': ['Make choux pastry.', 'Pipe and bake.', 'Fill and top with chocolate.']
        }
      ],
    },
    {
      'name': 'Chef Zam',
      'bio': 'Celebrity chef, culinary educator, and host of many TV cooking shows. Former culinary lecturer at UiTM.',
      'image': 'assets/images/chef_zam.jpg',
      'profileImage': 'assets/images/chef_zam.jpg',
      'recipes': [
        {
          'title': 'Chocolate Moist Cake',
          'description': 'Rich and moist chocolate cake with ganache.',
          'image': 'assets/images/choc_moist.jpg',
          'ingredients': ['Flour', 'Cocoa', 'Sugar', 'Eggs'],
          'instructions': ['Mix dry and wet ingredients.', 'Bake at 170°C.', 'Top with ganache.']
        },
        {
          'title': 'Baked Macaroni',
          'description': 'Creamy pasta baked with cheese.',
          'image': 'assets/images/baked_mac.jpg',
          'ingredients': ['Macaroni', 'Cream', 'Cheese', 'Minced meat'],
          'instructions': ['Boil macaroni.', 'Mix with sauce.', 'Bake with cheese.']
        },
        {
          'title': 'Pavlova',
          'description': 'Crispy meringue with soft center topped with fruits.',
          'image': 'assets/images/pavlova.jpg',
          'ingredients': ['Egg whites', 'Sugar', 'Cream', 'Fruits'],
          'instructions': ['Whisk egg whites.', 'Bake at low temp.', 'Top with cream and fruits.']
        }
      ],
    },
   {
      'name': 'Chef Wan',
      'bio': 'Malaysia’s most iconic celebrity chef, known for his cooking shows and travelogues. Promotes Malaysian cuisine globally.',
      'image': 'assets/images/chef_wan.jpg',
      'profileImage': 'assets/images/chef_wan.jpg',
      'recipes': [
        {
          'title': 'Butter Cake',
          'description': 'Classic butter cake with a golden crust and soft crumb.',
          'image': 'assets/images/butter_cake.jpg',
          'ingredients': ['Butter', 'Sugar', 'Eggs', 'Flour'],
          'instructions': ['Cream butter and sugar.', 'Add eggs and flour.', 'Bake at 170°C until golden.']
        },
        {
          'title': 'Pineapple Tart',
          'description': 'Delicate tart with homemade pineapple jam.',
          'image': 'assets/images/pineapple_tart.jpg',
          'ingredients': ['Flour', 'Butter', 'Egg yolk', 'Pineapple jam'],
          'instructions': ['Make dough.', 'Shape and fill with jam.', 'Bake until golden.']
        },
        {
          'title': 'Marble Cake',
          'description': 'Vanilla and chocolate swirled cake.',
          'image': 'assets/images/marble_cake.jpg',
          'ingredients': ['Butter', 'Sugar', 'Eggs', 'Cocoa powder'],
          'instructions': ['Prepare batter.', 'Swirl cocoa into half.', 'Bake until done.']
        },
        {
          'title': 'Pandan Chiffon Cake',
          'description': 'Soft and airy cake with fragrant pandan flavor.',
          'image': 'assets/images/pandan_chiffon.jpg',
          'ingredients': ['Eggs', 'Sugar', 'Pandan juice', 'Cake flour'],
          'instructions': ['Whisk egg whites.', 'Fold into batter.', 'Bake in chiffon tin.']
        }
      ],
    },
    {
      'name': 'Chef Florence Tan',
      'bio': 'Renowned Nyonya cuisine expert. Hosted Asian Food Channel programs and authored cookbooks on Peranakan food.',
      'image': 'assets/images/chef_florence.jpg',
      'profileImage': 'assets/images/chef_florence.jpg',
      'recipes': [
        {
          'title': 'Kuih Bahulu',
          'description': 'Traditional sponge mini cakes with crispy edges.',
          'image': 'assets/images/kuih_bahulu.jpg',
          'ingredients': ['Eggs', 'Sugar', 'Flour'],
          'instructions': ['Whisk eggs and sugar.', 'Fold in flour.', 'Bake in mould.']
        },
        {
          'title': 'Angku Kuih',
          'description': 'Glutinous rice cakes with mung bean filling.',
          'image': 'assets/images/angku_kuih.jpg',
          'ingredients': ['Glutinous rice flour', 'Sweet potato', 'Mung bean paste'],
          'instructions': ['Prepare dough and filling.', 'Shape and steam.']
        },
        {
          'title': 'Pulut Inti',
          'description': 'Sticky rice with sweet coconut topping.',
          'image': 'assets/images/pulut_inti.jpg',
          'ingredients': ['Glutinous rice', 'Coconut milk', 'Palm sugar'],
          'instructions': ['Steam rice.', 'Cook coconut with sugar.', 'Serve wrapped in banana leaf.']
        }
      ],
    },
    {
      'name': 'Chef Maria',
      'bio': 'Pastry chef specializing in European-style desserts. Known for precision and elegance.',
      'image': 'assets/images/chef_maria.jpeg',
      'profileImage': 'assets/images/chef_maria.jpeg',
      'recipes': [
        {
          'title': 'Opera Cake',
          'description': 'Layered almond sponge with coffee buttercream and ganache.',
          'image': 'assets/images/opera_cake.jpg',
          'ingredients': ['Almond flour', 'Eggs', 'Buttercream', 'Ganache'],
          'instructions': ['Bake sponge.', 'Layer with buttercream and ganache.', 'Chill and slice.']
        },
        {
          'title': 'Crème Brûlée',
          'description': 'Rich custard base with caramelized sugar top.',
          'image': 'assets/images/creme_brulee.jpg',
          'ingredients': ['Cream', 'Egg yolks', 'Sugar', 'Vanilla'],
          'instructions': ['Bake in water bath.', 'Chill and brûlée the top.']
        },
        {
          'title': 'Choux au Craquelin',
          'description': 'Cream puffs with crispy topping and pastry cream filling.',
          'image': 'assets/images/choux_craquelin.jpg',
          'ingredients': ['Flour', 'Butter', 'Eggs', 'Craquelin dough'],
          'instructions': ['Make choux.', 'Top with craquelin.', 'Bake and fill.']
        }
      ],
    },
    {
      'name': 'Chef Hafiz',
      'bio': 'Up-and-coming pastry chef focused on fusion desserts. Combines traditional and modern techniques.',
      'image': 'assets/images/chef_hafiz.jpg',
      'profileImage': 'assets/images/chef_hafiz.jpg',
      'recipes': [
        {
          'title': 'Onde-onde Cheesecake',
          'description': 'Fusion dessert combining pandan, coconut and cheese.',
          'image': 'assets/images/onde_onde_cheesecake.png',
          'ingredients': ['Cream cheese', 'Pandan juice', 'Grated coconut', 'Gula Melaka'],
          'instructions': ['Prepare cheesecake base.', 'Swirl pandan and gula melaka.', 'Bake and top with coconut.']
        },
        {
          'title': 'Matcha Mille Crepe',
          'description': 'Layers of matcha crepes and cream.',
          'image': 'assets/images/matcha_crepe.jpg',
          'ingredients': ['Matcha', 'Flour', 'Eggs', 'Whipped cream'],
          'instructions': ['Cook crepes.', 'Layer with cream.', 'Chill before slicing.']
        },
        {
          'title': 'Durian Macaron',
          'description': 'Crispy shells filled with creamy durian filling.',
          'image': 'assets/images/durian_macaron.jpg',
          'ingredients': ['Almond flour', 'Egg whites', 'Durian paste'],
          'instructions': ['Make shells.', 'Pipe durian filling.', 'Sandwich and chill.']
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet Our Chefs', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFFBC02D),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chefs.length,
        itemBuilder: (context, index) {
          final chef = chefs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  chef['image'],
                  width: 60,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(chef['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(chef['bio'], maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChefProfilePage(chefData: chef),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}