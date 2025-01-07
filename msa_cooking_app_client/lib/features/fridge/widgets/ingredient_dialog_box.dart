import 'package:flutter/material.dart';

class IngredientDialogBox extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 300,
        child: const Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                hintText: "Add new ingredient"
              ),
            )
          ],
        ),
      ),
    );
  }

}