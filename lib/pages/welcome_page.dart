import 'package:flutter/material.dart';
import 'seller_main_dashboard.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/baking_bg.png', fit: BoxFit.cover),
          Container(
            color: const Color.fromARGB(255, 255, 255, 255)
                .withAlpha((0.4 * 255).toInt()),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/app_logo.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 20),
                    Icon(
                      Icons.emoji_food_beverage,
                      size: 60,
                      color: Color(0xFFFBC02D),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "LET'S GET BAKING!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your one-stop app for baking ingredients, recipes, and more.",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFBC02D),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                      child:
                          Text("Login", style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(height: 12),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFFFBC02D)),
                        padding: EdgeInsets.symmetric(
                          horizontal: 38,
                          vertical: 14,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterPage()),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SellerMainDashboard(),
                          ),
                        );
                      },
                      child: Text(
                        "Go to Seller Dashboard",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}