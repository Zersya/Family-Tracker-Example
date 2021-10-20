import 'package:trans_trackid_example/models/meta.dart';
import 'package:trans_trackid_example/utils/enum.dart';

/// Base class for handle response of dio request
class ResponseOfRequest<MapString> extends BaseResponse<MapString> {
  /// Constructor that able to use attribute parent
  ResponseOfRequest(
      {String? message, Meta? meta, MapString? data, this.statusCode})
      : super(data: data, message: message, meta: meta);

  /// Getter the status code of the response.
  int? statusCode;
}

/// Base class for all the response API, with generic data type on [data].
class BaseResponse<T> {
  /// Base constructor for all casted response.
  BaseResponse({
    this.data,
    this.status,
    this.meta,
    this.message,
  });

  /// Success response state
  factory BaseResponse.success(T data, {Meta? meta}) {
    return BaseResponse<T>(
        data: data, status: ResponseStatus.success, meta: meta);
  }

  /// Success response state
  factory BaseResponse.failure(String? message) {
    return BaseResponse<T>(message: message, status: ResponseStatus.failed);
  }

  /// Getter the response status success, failure
  ResponseStatus? status;

  /// Getter the response message.
  String? message;

  /// Getter the response meta, for meta List.
  Meta? meta;

  /// Getter the response data.
  T? data;
}
