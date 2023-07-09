class ExeptionMessage implements Exception {
  final String message;

  ExeptionMessage({required this.message});
}

class CepNotFoundException extends ExeptionMessage {
  CepNotFoundException({required super.message});
}

class CepSaveException extends ExeptionMessage {
  CepSaveException({required super.message});
}

class CepEditException extends ExeptionMessage {
  CepEditException({required super.message});
}

class CepDeleteException extends ExeptionMessage {
  CepDeleteException({required super.message});
}

class CepExitsException extends ExeptionMessage {
  CepExitsException({required super.message});
}
