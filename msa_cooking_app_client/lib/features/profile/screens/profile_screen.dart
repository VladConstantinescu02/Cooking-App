import 'dart:io';

import 'package:flutter/material.dart';
import 'package:msa_cooking_app_client/components/text_box.dart';
import 'package:msa_cooking_app_client/features/profile/components/profile_photo_chooser.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String? path;

  void choosePhoto(BuildContext context) async {
    final pickedFile = await pickAnImage();
    if (pickedFile == null) {
      return;
    }

    final path = pickedFile.path;

    final croppedFile = await croppedImage(path);

    if (croppedFile == null) {
      return;
    }

    setState(() {
      this.path = croppedFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Consistent horizontal padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center align the contents horizontally
            children: [
              const SizedBox(height: 20),

              // Profile Section
              Center(
                child: Stack(
                  children: [
                    if (path != null)
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.file(File(path!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: -4,
                      left: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                          elevation: 0,
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2
                          )
                        ),
                        child: Icon(
                          Icons.settings,
                          color: Colors.grey[50],
                          size: 20,
                        ),
                        onPressed: () => choosePhoto(context),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30), // Add spacing between profile section and text box

              // Username Section
              Align(
                alignment: Alignment.centerLeft, // Align the "Your info" text to the left
                child: Text(
                  "Your info:",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const MyTextBox(
                text: 'Johnny Test',
                sectionName: 'Username',
              ),

              const SizedBox(height: 10), // Spacing between text box and divider
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}