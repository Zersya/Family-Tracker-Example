import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable(createToJson: false)
class Device {
  Device(
    this.id,
    this.name,
    this.avatar,
    this.latitude,
    this.longitude,
    this.createdAt,
  );

  /// Converter from response map data to model
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  // /// Converter from model to map data for request
  // Map<String, dynamic> toJson() => _$DeviceToJson(this);

  final String id;

  final String name;

  final String avatar;

  final String latitude;

  final String longitude;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(ignore: true)
  Uint8List? avatarBytes;
}
