import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/images_api_client_provider.dart';

class ProfileAvatar extends ConsumerWidget {
  final String imageName;

  const ProfileAvatar(this.imageName, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesApiClient = ref.watch(imagesApiClientProvider);

    return FutureBuilder<Uint8List?>(
      future: imagesApiClient.getImage(imageName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey,
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return CircleAvatar(
            radius: 60,
            backgroundImage: const AssetImage('assets/images/default_profile.png'),
            backgroundColor: Colors.grey[200],
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return CircleAvatar(
            radius: 60,
            backgroundImage: MemoryImage(snapshot.data!),
            backgroundColor: Colors.grey[200],
          );
        }

        return CircleAvatar(
          radius: 60,
          backgroundImage: const AssetImage('assets/images/default_profile.png'),
          backgroundColor: Colors.grey[200],
        );
      },
    );
  }

}