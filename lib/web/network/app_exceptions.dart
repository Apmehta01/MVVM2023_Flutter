import '../../utils/Constants.dart';

class AppException implements Exception{
  final _message;
  final _prefix;
  AppException(this._message, this._prefix);

  String toString(){
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppException{
  FetchDataException([String? message]):super(message,Constants.CONNECTION_TIMEOUT);
}

class BadRequestException extends AppException{
  BadRequestException([String? message]):super(message,Constants.BAD_REQUEST_EXCEPTION);
}

class UnAuthorizeException extends AppException{
  UnAuthorizeException([String? message]):super(message,Constants.TOKEN_EXPIRE);
}

class InvalidInputException extends AppException{
  InvalidInputException([String? message]):super(message,Constants.INVALID_INPUT);
}