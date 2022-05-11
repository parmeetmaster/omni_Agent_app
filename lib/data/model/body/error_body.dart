// To parse this JSON data, do
//
//     final errorBody = errorBodyFromJson(jsonString);

import 'dart:convert';

ErrorBody errorBodyFromJson(String str) => ErrorBody.fromJson(json.decode(str));

class ErrorBody {
  ErrorBody({
    this.errors,
  });

  List<Error> errors;

  factory ErrorBody.fromJson(Map<String, dynamic> json) => ErrorBody(
    errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
  );
}

class Error {
  Error({
    this.message,
  });

  String message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    message: json["message"],
  );

}
