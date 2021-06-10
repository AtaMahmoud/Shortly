class Failure {
  final String? errorMessage;
  final dynamic error;
  

  Failure({this.error, required this.errorMessage,});

  @override
  String toString() {
    return errorMessage.toString();
  }
}
