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

    return profileAsync.when(
      data: (profile) => _buildProfileContent(context, profile, ref),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(context),
    );
  }

  Widget _buildProfileContent(BuildContext context, profile_model.Profile profile, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileAvatar(profile.profilePhotoUrl ?? ''),
          const SizedBox(height: 24),

          _buildNameAndUsername(context, profile),
          const SizedBox(height: 32),

          _buildInfoCard(context, profile),

          const SizedBox(height: 40),

          _buildActionButtons(context, ref, profileAsync),
        ],
      ),
    );
  }

  Widget _buildNameAndUsername(BuildContext context, profile_model.Profile profile) {
    return Column(
      children: [
        Text(
          profile.fullName ?? 'Guest User',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        if (profile.userName != null)
          Text(
            '@${profile.userName}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, profile_model.Profile profile) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSectionHeader(context, 'Allergens'),
            if (profile.alergens != null && profile.alergens!.isNotEmpty)
              ...profile.alergens!.map((alergen) => ListTile(
                leading: const Icon(Icons.warning_amber_outlined),
                title: Text(alergen.name),
              )),
            if (profile.alergens == null || profile.alergens!.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('No allergens listed.'),
              ),
            const SizedBox(height: 16),
            _buildSectionHeader(context, 'Dietary Restrictions'),
            if (profile.dietRestriction != null)
              ListTile(
                leading: const Icon(Icons.restaurant_menu),
                title: Text(profile.dietRestriction!.name),
              ),
            if (profile.dietRestriction == null)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('No dietary restrictions listed.'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Text(
            'Failed to load profile. Please try again.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, AsyncValue<profile_model.Profile> profileAsync) {
    return Column(
      children: [
        // Edit Profile Button
        _buildStyledButton(
          context,
          onPressed: () {
            GoRouter.of(context).go('/update-profile');
          },
          icon: const Icon(Icons.edit),
          label: const Text('Edit Profile'),
          color: Colors.blue,
        ),
        const SizedBox(height: 16),

        _buildStyledButton(
          context,
          onPressed: () {
            _showDeleteDialog(context, ref, profileAsync);
          },
          icon: const Icon(Icons.delete),
          label: const Text('Delete Profile'),
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildStyledButton(
      BuildContext context, {
        required VoidCallback onPressed,
        required Icon icon,
        required Text label,
        required Color color,
      }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, AsyncValue<profile_model.Profile> profileAsync) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete profile'),
        content: const Text('Are you sure you want to delete your profile?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: profileAsync.isLoading
                ? null
                : () async {
              await ref.read(profileProvider.notifier).deleteProfile(context);
              Navigator.of(context).pop();
            },
            child: profileAsync.isLoading
                ? const CircularProgressIndicator()
                : const Text("Delete Profile"),
          ),
        ],
      ),
    );
  }
}
