import 'package:flutter/material.dart';
import '../widgets/challenge_card.dart';
import 'package:lottie/lottie.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Lets get cooking!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Lottie.asset(
              'images/stir_animation.json',
              width: 300,
              height: 300,
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: <Widget>[
                ChallengeCard(
                  onTap: () {
                    debugPrint('Go to page');
                  },
                  icon: const Icon(Icons.set_meal_rounded, color: Colors.white, size: 40),
                  text: 'Lets build your fridge',
                  cardColor: const Color(0xFF8FB1BE),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
                ChallengeCard(
                  onTap: () {
                    debugPrint('Go to page');
                  },
                  icon: const Icon(Icons.fastfood, color: Colors.black, size: 40),
                  text: 'Create your meals',
                  cardColor: const Color(0xFFEEE3AB),
                  textColor: Colors.black,
                  iconColor: Colors.black,
                ),
                ChallengeCard(
                  onTap: () {
                    debugPrint('Go to page');
                  },
                  icon: const Icon(Icons.account_circle, color: Colors.white, size: 40),
                  text: 'Set up your profile',
                  cardColor: const Color(0xFF561D25),
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}