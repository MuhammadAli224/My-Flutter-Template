abstract class Failure {
  final String message;
  final String? title;

  Failure({required this.message, this.title});

  @override
  String toString() => "message : $message , title : $title";
}

abstract class Success {
  final String message;

  Success({required this.message});

  @override
  String toString() => message;
}
