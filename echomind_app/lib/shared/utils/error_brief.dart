import 'package:dio/dio.dart';

String withErrorDetails(String title, Object error) {
  final detail = briefError(error);
  if (detail.isEmpty) return title;
  return '$title\n$detail';
}

String briefError(Object error) {
  if (error is DioException) {
    final status = error.response?.statusCode;
    final info = _extractResponseMessage(error.response) ??
        error.message ??
        error.error?.toString() ??
        error.type.name;

    final shortInfo = _shorten(_normalize(info));
    if (status != null) {
      return 'Code: $status, Message: $shortInfo';
    }
    return 'Message: $shortInfo';
  }

  final text = _shorten(_normalize(error.toString()));
  if (text.isEmpty) return '';
  return 'Message: $text';
}

String? _extractResponseMessage(Response<dynamic>? response) {
  final data = response?.data;
  if (data == null) return null;

  if (data is Map) {
    final detail = data['detail'];
    if (detail is String && detail.trim().isNotEmpty) {
      return detail;
    }
    if (detail is List && detail.isNotEmpty) {
      final first = detail.first;
      if (first is Map) {
        final msg = first['msg'];
        if (msg is String && msg.trim().isNotEmpty) {
          return msg;
        }
      }
      return detail.toString();
    }
    return data.toString();
  }

  if (data is String) {
    return data;
  }

  return data.toString();
}

String _normalize(String value) {
  final oneLine = value.replaceAll(RegExp(r'\s+'), ' ').trim();
  return oneLine
      .replaceAll('DioException: ', '')
      .replaceAll('Exception: ', '')
      .trim();
}

String _shorten(String value, {int max = 120}) {
  if (value.length <= max) return value;
  return '${value.substring(0, max)}...';
}
