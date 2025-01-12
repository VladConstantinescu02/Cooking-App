import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:msa_cooking_app_client/features/profile/providers/profile_provider.dart';
import 'package:msa_cooking_app_client/features/profile/models/profile.dart' as profile_model;
import 'package:msa_cooking_app_client/features/profile/widgets/profile_avatar.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: profileAsync.when(
        data: (profile) => _buildProfileContent(context, profile, ref),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 50),
              const SizedBox(height: 16),
              Text(
                'Failed to load profile. Please try again.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, profile_model.Profile profile, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileAvatar(profile.profilePhotoUrl ?? ''),
            const SizedBox(height: 16),
            Text(
              profile.fullName ?? 'Guest User',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (profile.userName != null)
              Text(
                '@${profile.userName}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey),
              ),
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Allergens'),
            if (profile.alergens != null && profile.alergens!.isNotEmpty)
              ...profile.alergens!.map((alergen) => ListTile(
                leading: const Icon(Icons.warning_amber_outlined),
                title: Text(alergen.name),
              )),
            if (profile.alergens == null || profile.alergens!.isEmpty)
              const Text('No allergens listed.'),
            const SizedBox(height: 16),
            _buildSectionHeader(context, 'Dietary Restrictions'),
            if (profile.dietRestriction != null)
              ListTile(
                leading: const Icon(Icons.restaurant_menu),
                title: Text(profile.dietRestriction!.name),
              ),
            if (profile.dietRestriction == null)
              const Text('No dietary restrictions listed.'),
            const SizedBox(height: 32),
            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () {
                GoRouter.of(context).go('/update-profile');
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
