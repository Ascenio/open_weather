import 'dart:convert';

import 'package:http/http.dart';
import 'package:open_weather/core/data/http_client.dart';

final class ExternalHttpClient implements HttpClient {
  const ExternalHttpClient();

  @override
  Future<T> request<T>(
    String url, {
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: queryParameters,
    );
    final response = await get(uri);
    final json = jsonDecode(response.body);
    return json;
  }
}
