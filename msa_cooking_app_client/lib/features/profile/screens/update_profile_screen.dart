import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_dietary_option.dart';
import 'package:msa_cooking_app_client/features/profile/providers/profile_provider.dart';
import '../../../shared/models/search_ingredient.dart';
import '../../../shared/widgets/search_ingredients.dart';
import '../../meals/providers/dietary_options_provider.dart';
import '../models/create_profile.dart';
import '../models/profile.dart' as profile_model;
import '../widgets/profile_avatar.dart';

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
  final List<SearchIngredient> _ingredientsToAvoid = [];
  String? _profilePhotoName;

  void _loadProfile() {
    final profile = ref.read(profileProvider);
    if (profile is AsyncData<profile_model.Profile>) {
      if (_userNameController.text.isEmpty) {
        _userNameController.text = profile.value.userName ?? '';
      }
      if (_ingredientsToAvoid.isEmpty) {
        _ingredientsToAvoid.addAll(profile.value.alergens?.map((a) => SearchIngredient(a.id, a.name)) ?? []);
      }
      _selectedDietaryOption ??= profile.value.dietRestriction != null
          ? GetDietaryOption(profile.value.dietRestriction!.id, profile.value.dietRestriction!.name)
          : null;
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

  Future<void> _updateProfile(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final ingredientsToAvoidIds = _ingredientsToAvoid.isNotEmpty
          ? _ingredientsToAvoid.map((i) => i.id).toList()
          : null;

      final createProfile = CreateProfile(
        _userNameController.text,
        ingredientsToAvoidIds,
        _selectedDietaryOption?.id,
        _profilePhoto,
      );
      await ref.read(profileProvider.notifier).updateProfile(createProfile, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadProfile();
    final dietaryOptionsAsyncValue = ref.watch(dietaryOptionsProvider);
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Photo Section
                Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 65, right: 65, top: 10, bottom: 10),
                      child: Column(
                        children: [
                          _profilePhoto != null ?
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(_profilePhoto!),
                            ) : ProfileAvatar(_profilePhotoName ?? ''),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.camera_alt_outlined),
                            label: const Text("Pick Profile Photo"),
                          ),
                        ],
                      ),
                    )
                ),
                const SizedBox(height: 10),
                Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Username Input Field
                          TextFormField(
                            controller: _userNameController,
                            decoration: InputDecoration(
                              icon: const Icon(Icons.person),
                              labelText: "Username",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              filled: true,
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
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Select Dietary Option",
                                icon: const Icon(Icons.food_bank_outlined),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                        ],
                      ),
                    )
                ),
                const SizedBox(height: 10),
                // Add Ingredients Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Add ingredients to avoid", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                    FloatingActionButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                          context: context,
                          builder: (context) => SearchIngredients(onIngredientSelected: _onIngredientSelected, _ingredientsToAvoid),
                        );
                      },
                      child: const Icon(Icons.add, size: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                if (_ingredientsToAvoid.isNotEmpty) ...[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _ingredientsToAvoid.length,
                    itemBuilder: (context, index) {
                      final ingredient = _ingredientsToAvoid[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          title: Text(ingredient.name, style: const TextStyle(fontSize: 16)),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                _ingredientsToAvoid.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container();
                    },
                  ),
                ],
                const SizedBox(height: 5),
                if (profileState.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () => _updateProfile(context),
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