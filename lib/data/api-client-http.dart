import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api-client-interfaz.dart';

class HttpApiClient implements ApiClient {
  final http.Client client;

  HttpApiClient(this.client);

  @override
  Future<String> get(String url, Map<String, String> headers) async {
    final response = await client.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      String decodedBody = utf8.decode(response.bodyBytes);
      return decodedBody;
    } else {
      throw Exception("Error al obtener datos");
    }
  }
}
