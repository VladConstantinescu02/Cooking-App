import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_dietary_option.dart';
import 'package:msa_cooking_app_client/features/profile/providers/profile_provider.dart';
import 'package:msa_cooking_app_client/features/profile/widgets/profile_avatar.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/profile_api_client_provider.dart';

import '../../../shared/models/search_ingredient.dart';
import '../../meals/providers/dietary_options_provider.dart';
import '../models/create_profile.dart';
import '../models/create_profile_response.dart';
import '../models/profile.dart' as profile_model;
import '../widgets/add_ingredients_to_avoid_dialog.dart';

class UpdateProfileScreen extends ConsumerStatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UpdateProfileScreenState();
  }
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  File? _profilePhoto;
  GetDietaryOption? _selectedDietaryOption;
  List<SearchIngredient> _ingredientsToAvoid = [];
  bool _isLoading = false;

  String? _profilePhotoName;

  void _loadProfile() {
    final profile = ref.watch(profileProvider);
    if (profile is AsyncData<profile_model.Profile>) {
      _userNameController.text = profile.value.userName ?? '';
      _selectedDietaryOption = GetDietaryOption(profile.value.dietRestriction?.id ?? 0, profile.value.dietRestriction?.name ?? '');
      _ingredientsToAvoid = [];
      _ingredientsToAvoid.addAll(profile.value.alergens?.map((a) => SearchIngredient(a.id, a.name)) ?? List.empty());
      if (profile.value.profilePhotoUrl != null) {
        _profilePhotoName = profile.value.profilePhotoUrl;
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePhoto = File(pickedFile.path);
      });
    }
  }

  void _onIngredientSelected(SearchIngredient ingredient) {
    setState(() {
      if (!_ingredientsToAvoid.any((i) => i.id == ingredient.id)) {
        _ingredientsToAvoid.add(ingredient);
      }
    });
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final ingredientsToAvoidIds = _ingredientsToAvoid.isNotEmpty
          ? _ingredientsToAvoid.map((i) => i.id).toList()
          : null;

      final createProfile = CreateProfile(
        _userNameController.text,
        ingredientsToAvoidIds,
        _selectedDietaryOption?.id,
        _profilePhoto,
      );

      final result = await ref.read(profileApiClientProvider).updateProfile(createProfile);

      setState(() {
        _isLoading = false;
      });

      if (result is Success<CreateProfileResponse, Exception>) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Success"),
            content: const Text("Profile updated successfully!"),
            actions: [
              TextButton(
                onPressed: () async {
                  await ref.read(profileProvider.notifier).getProfile().then((data) {
                    GoRouter.of(context).go("/profile");
                  });
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else if (result is Failure<CreateProfileResponse, Exception>) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${result.exception.toString()}")),
        );
      }
    }
  }

  Widget _renderProfilePhotoSection() {
    if (_profilePhoto != null) {
      return CircleAvatar(
          radius: 50,
          backgroundImage: FileImage(_profilePhoto!),
        );
    } else {
      return ProfileAvatar(_profilePhotoName ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadProfile();
    final dietaryOptionsAsyncValue = ref.watch(dietaryOptionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _renderProfilePhotoSection(),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: _pickImage,
                  child: const Text("Pick Profile Photo"),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "Username",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your username";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                dietaryOptionsAsyncValue.when(
                  data: (dietaryOptions) => DropdownButtonFormField<String>(
                    value: _selectedDietaryOption?.name,
                    decoration: const InputDecoration(
                      labelText: "Select Dietary Option",
                      icon: Icon(Icons.food_bank_outlined),
                      border: OutlineInputBorder(),
                    ),
                    items: dietaryOptions.map((option) {
                      return DropdownMenuItem<String>(
                        value: option.name,
                        child: Text(option.name),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDietaryOption = dietaryOptions.firstWhere((o) => o.name == newValue);
                      });
                    },
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                const SizedBox(height: 20),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Add ingredients to avoid", style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 40,
                      onPressed: () async {
                        await showAdaptiveDialog(
                          context: context,
                          builder: (context) => AddIngredientsToAvoidDialog(
                            _ingredientsToAvoid,
                            onIngredientSelected: _onIngredientSelected,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                if (_ingredientsToAvoid.isNotEmpty) ...[
                  const Divider(),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _ingredientsToAvoid.length,
                    itemBuilder: (context, index) {
                      final ingredient = _ingredientsToAvoid[index];
                      return ListTile(
                        title: Text(ingredient.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              _ingredientsToAvoid.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, _) => const Divider(),
                  ),
                ],
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  OutlinedButton(
                    onPressed: _updateProfile,
                    child: const Text("Update Profile"),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }
}