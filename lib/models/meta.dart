import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable(createToJson: false)

/// Meta data for a response from API.
/// For example response of any list
class Meta {
  /// Called on any repository that required meta data
  Meta(this.status, this.message);

  /// Converter from response map data to model
  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  // /// Converter from model to map data for request
  // Map<String, dynamic> toJson() => _$MetaToJson(this);

  /// Status of response
  /// For example:
  /// - true: Success
  /// - false: Failed
  final String message;

  /// Success boolean of response
  /// For example:
  /// - true: Success
  /// - false: Failed
  final bool status;
}
