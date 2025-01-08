import 'package:flutter/material.dart';

import 'button.dart';

class IngredientDialogBox extends StatefulWidget {
  final TextEditingController controllerName;
  final TextEditingController controllerCalorie;
  final TextEditingController controllerAmount;
  final Function(String) onSave; // Accepts a function with a String parameter
  final VoidCallback onCancel;

  const IngredientDialogBox({
    super.key,
    required this.controllerName,
    required this.controllerCalorie,
    required this.controllerAmount,
    required this.onCancel,
    required this.onSave,
  });

  @override
  State<IngredientDialogBox> createState() => _IngredientDialogBoxState();
}

class _IngredientDialogBoxState extends State<IngredientDialogBox> {
  // Dropdown options
  final List<String> quantityTypes = ['g', 'kg', 'ml', 'l'];
  String selectedType = 'g';
  String? doubleErrorCalorie;
  String? doubleErrorAmount;


  // Custom InputDecoration for consistent style
  InputDecoration customInputDecoration(String hintText, [String? errorText]) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black54),
      filled: true,
      fillColor: Colors.white,
      errorText: errorText, // Display the error message
      errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
    );
  }

  void validateDoubleInputAmount(String value) {
    setState(() {
      doubleErrorAmount = double.tryParse(value)== null ? "Provide amount" : null;
    });
  }

  void validateDoubleInputCalorie(String value) {
    setState(() {
      doubleErrorCalorie = double.tryParse(value) == null ? "Please provide a valid number" : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Name input field
            TextField(
              controller: widget.controllerName,
              decoration: customInputDecoration("Add new ingredient"),
              style: const TextStyle(color: Colors.black87),
            ),


            TextField(
              controller: widget.controllerCalorie,
              decoration: customInputDecoration("Add calories amount", doubleErrorCalorie),
              style: const TextStyle(color: Colors.black87),
              keyboardType: TextInputType.number,
              onChanged: validateDoubleInputCalorie,
            ),


            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: widget.controllerAmount,
                    decoration: customInputDecoration("Add weight", doubleErrorAmount),
                    style: const TextStyle(color: Colors.black87),
                    keyboardType: TextInputType.number,
                    onChanged: validateDoubleInputAmount,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: selectedType,
                    items: quantityTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(
                          type,
                          style: const TextStyle(color: Colors.black87),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedType = newValue!;
                      });
                    },
                    decoration: customInputDecoration("Unit"),
                  ),
                ),
              ],
            ),

            // Save and Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyButton(
                  contentText: 'Save',
                  onPressed: () {
                    if (doubleErrorCalorie == null) {
                      widget.onSave(selectedType);
                    }
                  },
                ),
                MyButton(
                  contentText: 'Cancel',
                  onPressed: widget.onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
