import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msa_cooking_app_client/features/meals/models/get_dietary_option.dart';
import 'package:msa_cooking_app_client/features/profile/providers/profile_provider.dart';
import 'package:msa_cooking_app_client/shared/errors/result.dart';
import 'package:msa_cooking_app_client/shared/providers/profile_api_client_provider.dart';

import '../../../shared/models/search_ingredient.dart';
import '../../meals/providers/dietary_options_provider.dart';
import '../models/create_profile.dart';
import '../models/create_profile_response.dart';
import '../widgets/add_ingredients_to_avoid_dialog.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateProfileScreenState();
  }
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  File? _profilePhoto;
  GetDietaryOption? _selectedDietaryOption;
  final List<SearchIngredient> _ingredientsToAvoid = [];
  bool _isLoading = false;

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

  Future<void> _createProfile(BuildContext context) async {
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

      await ref.read(profileProvider.notifier).createProfile(createProfile, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dietaryOptionsAsyncValue = ref.watch(dietaryOptionsProvider);
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Profile")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_profilePhoto != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(_profilePhoto!),
                  ),
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
                if (profileState.isLoading)
                  const CircularProgressIndicator()
                else
                  OutlinedButton(
                    onPressed: () => _createProfile(context),
                    child: const Text("Create Profile"),
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
