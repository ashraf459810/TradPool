class ServerException implements Exception {
  final String error;

  String get theError {
    return error;
  }

  ServerException([this.error]);
}
