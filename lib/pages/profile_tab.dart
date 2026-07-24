import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController(
    text: "Sweet Whisk Bakers",
  );
  final TextEditingController emailController = TextEditingController(
    text: "sweetwhisk@email.com",
  );
  final TextEditingController phoneController = TextEditingController(
    text: "+6012-345 6789",
  );
  final TextEditingController locationController = TextEditingController(
    text: "Johor Bahru, Malaysia",
  );
  final TextEditingController activeSinceController = TextEditingController(
    text: "2022",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFBC02D),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.check : Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/shop_logo.png'),
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(height: 20),
            isEditing
                ? TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Business Name",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                )
                : Text(
                  nameController.text,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
            SizedBox(height: 5),
            Text(
              "Home-based baking ingredients supplier",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            buildProfileField(Icons.email, "Email", emailController),
            Divider(),

            buildProfileField(Icons.phone, "Phone", phoneController),
            Divider(),

            buildProfileField(
              Icons.location_on,
              "Location",
              locationController,
            ),
            Divider(),

            buildProfileField(
              Icons.storefront,
              "Active Since",
              activeSinceController,
            ),
            Divider(),

            SizedBox(height: 30),

            if (isEditing)
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isEditing = false;
                    // You could save to backend here
                  });
                },
                icon: Icon(Icons.save, color: Colors.black),
                label: Text(
                  "Save Changes",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBC02D),
                ),
              ),

            SizedBox(height: 20),
            Text(
              "Bake Mart Seller",
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(
    IconData icon,
    String label,
    TextEditingController controller,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title:
          isEditing
              ? TextField(
                controller: controller,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              )
              : Text(controller.text, style: TextStyle(color: Colors.black)),
    );
  }
}
