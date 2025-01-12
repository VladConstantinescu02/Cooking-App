import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;


class ImagesApiClient {
  final String _baseAddress;
  final http.Client client;
  final String token;

  ImagesApiClient(this._baseAddress, this.client, this.token);

  Future<Uint8List?> getImage(String imageName) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await client.get(Uri.http(_baseAddress, "api/images", { 'imageName': imageName }), headers: headers);
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log("Error when retrieving image $e");
      return null;
    }
  }
}