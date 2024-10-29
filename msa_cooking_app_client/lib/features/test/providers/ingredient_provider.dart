import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:msa_cooking_app_client/features/test/domain/models/ingredient.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

part "ingredient_provider.g.dart";

@riverpod
Future<List<Ingredient>> ingredient(Ref red) async {
  final ioc = HttpClient();
  ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  final http = IOClient(ioc);

  final response = await http.get(Uri.https("192.168.1.142:5001", "/api/ingredients"));
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return json.map<Ingredient>((json) => Ingredient.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load ingredients: ${response.statusCode} - ${response.body}');
  }
}