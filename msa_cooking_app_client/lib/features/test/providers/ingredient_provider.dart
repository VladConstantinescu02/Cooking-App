import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/authentication/providers/authentication_provider.dart';
import 'package:msa_cooking_app_client/features/test/domain/models/ingredient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/io_client.dart';

part "ingredient_provider.g.dart";

@riverpod
Future<List<Ingredient>> ingredient(Ref ref) async {
  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = IOClient(ioc);

  final token = ref.read(authenticationProvider).value?.token;
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': "Bearer $token"
  };
  log("Making request...");
  final response = await http.get(Uri.https("192.168.1.142:5001", "/api/ingredients"), headers: headers);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return json.map<Ingredient>((json) => Ingredient.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load ingredients: ${response.statusCode} - ${response.body}');
  }
}