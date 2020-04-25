class HttpException implements Exception{

  String message;
  @override
  String toString() {
    return message;
  }

  HttpException(this.message);
}