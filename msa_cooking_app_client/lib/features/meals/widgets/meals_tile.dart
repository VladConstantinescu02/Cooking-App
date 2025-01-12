import 'package:flutter/material.dart';

class MealsTile extends StatelessWidget {
  const MealsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners for the image
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.cover,  // Use cover for better scaling of the image
                  image: AssetImage(
                    'images/meals_tile_background.png',
                  ),
                ),
              ),
              height: 100.0, // You can make this dynamic if necessary
            ),
          ),
          Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16), // Rounded corners for the overlay
              gradient: LinearGradient(
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft,
                colors: [
                  Colors.grey.withOpacity(0.0),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.9),
                  Colors.black,
                ],
                stops: const [
                  0.0,
                  0.35,
                  0.55,
                  1.0,
                ],
              ),
            ),
          ),
          // Positioned the text at the bottom of the container
          const Positioned(
            bottom: 10.0, // Adjust the vertical position of the text
            left: 16.0, // Adjust the horizontal position
            child: Text(
              'Meal name',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0, // Adjust font size for better readability
              ),
            ),
          ),
        ],
      ),
    );
  }
}
