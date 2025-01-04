import 'package:http/http.dart' as http;

class ApiClient extends http.BaseClient {
  final http.Client _inner;

  ApiClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request);
  }

}