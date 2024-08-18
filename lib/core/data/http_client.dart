abstract interface class HttpClient {
  Future<T> request<T>(
    String url, {
    Map<String, String>? queryParameters,
  });
}
