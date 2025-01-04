import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  final String type;
  final String title;
  final int status;
  final String detail;
  final String traceId;

  ErrorResponse(this.type, this.title, this.status, this.detail, this.traceId);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}