import 'dart:convert';
import 'package:http/http.dart';

class GoogleAuthClient extends BaseClient {
  final Map<String, String> defaultHeaders;
  Client _httpClient = new Client();

  GoogleAuthClient({this.defaultHeaders = const {}});

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }

  @override
  Future<Response> get(url, {Map<String, String> headers}) {
    headers.addAll(defaultHeaders);
    return _httpClient.get(url, headers: headers);
  }

  @override
  Future<Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    headers.addAll(defaultHeaders);
    return _httpClient.post(url, headers: headers, encoding: encoding);
  }

  @override
  Future<Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    headers.addAll(defaultHeaders);
    return _httpClient.patch(url, headers: headers, encoding: encoding);
  }

  @override
  Future<Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    headers.addAll(defaultHeaders);
    return _httpClient.put(url,
        headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> head(url, {Map<String, String> headers}) {
    headers.addAll(defaultHeaders);
    return _httpClient.head(url, headers: headers);
  }

  @override
  Future<Response> delete(url, {Map<String, String> headers}) {
    headers.addAll(defaultHeaders);
    return _httpClient.delete(url, headers: headers);
  }
}