class CustomException implements Exception {
  final String message;
  final String code;

  const CustomException({
    required this.message,
    required this.code,
  });

  @override
  String toString() => message;
}
