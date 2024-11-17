import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
 // final void Function()? onPressed;

  const MyTextBox(  {
    super.key,
    required this.text,
    required this.sectionName,
    //required this.onPressed
    }
  );

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //section name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  sectionName,
                  style: TextStyle(color: Colors.grey[500]),
              ),

              IconButton(
                  //onPressed: onPressed,
                  onPressed: () {},
                  icon: Icon(Icons.settings, color: Colors.grey[500],))
            ],
          ),
          //Text
          Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ],
      ),
    );
  }
}