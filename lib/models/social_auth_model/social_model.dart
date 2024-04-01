class SocialModel {
  final int? statusCode;
  final String? message;
  final Map<String, dynamic>? data;

  SocialModel(
      {required this.statusCode, required this.message, required this.data});

  factory SocialModel.fromJson(Map<String, dynamic> json) {
    return SocialModel(
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] ?? {},
    );
  }
}
