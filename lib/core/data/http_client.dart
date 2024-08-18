abstract interface class HttpClient {
  Future<T> request<T>({
    Map<String, String>? queryParameters,
  });
}
