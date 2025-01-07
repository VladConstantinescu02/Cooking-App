import 'package:flutter/material.dart';

import 'button.dart';

class IngredientDialogBox extends StatelessWidget {
  final controllerName;
  final controllerAmount;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  IngredientDialogBox({
    super.key,
    required this.controllerName,
    required this.controllerAmount,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Add new ingredient"),
            ),
            TextField(
              controller: controllerAmount,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add calories amount"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //save
                MyButton(contentText: 'Save', onPressed: onSave),
                //cancel
                MyButton(contentText: 'Cancel', onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
