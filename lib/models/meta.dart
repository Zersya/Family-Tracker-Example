import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable()

/// Meta data for a response from API.
/// For example response of any list
class Meta {
  /// Called on any repository that required meta data
  Meta(this.status, this.success);

  /// Converter from response map data to model
  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  /// Converter from model to map data for request
  Map<String, dynamic> toJson() => _$MetaToJson(this);

  /// Status of response
  /// For example:
  /// - 200: Success
  /// - 400: Bad request
  /// - 500: Internal server error
  final int status;

  /// Success boolean of response
  /// For example:
  /// - true: Success
  /// - false: Failed
  final bool success;
}
