// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModelTest {
  int? status_code;
  String? message;
  ModelTest({
    this.status_code,
    this.message,
  });

  ModelTest copyWith({
    int? status_code,
    String? message,
  }) {
    return ModelTest(
      status_code: status_code ?? this.status_code,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status_code': status_code,
      'message': message,
    };
  }

  factory ModelTest.fromJson(Map<String, dynamic> map) {
    return ModelTest(
      status_code:
          map['status_code'] != null ? map['status_code'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }


  @override
  String toString() =>
      'ModelTest(status_code: $status_code, message: $message)';

  @override
  bool operator ==(covariant ModelTest other) {
    if (identical(this, other)) return true;

    return other.status_code == status_code && other.message == message;
  }

  @override
  int get hashCode => status_code.hashCode ^ message.hashCode;
}
