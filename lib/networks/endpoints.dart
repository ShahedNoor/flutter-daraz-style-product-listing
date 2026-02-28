// ignore_for_file: constant_identifier_names
const String url = "https://fakestoreapi.com/";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  // Auth
  static String login() => "auth/login";
  static String signup() => "users";

  // Example
  static String example() => "/api/";

  // Product Listing (FakeStore)
  static String products() => "products";
}
