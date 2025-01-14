import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;
  final String text;
  final Color cardColor;
  final Color textColor;
  final Color iconColor;

  const ChallengeCard({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.cardColor,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: cardColor,
        child: InkWell(
          splashColor: Colors.white60,
          onTap: onTap,
          child: SizedBox(
            height: 75,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: icon,
                ),
                const SizedBox(width: 15),
                Row(
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: iconColor, size: 40,)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
