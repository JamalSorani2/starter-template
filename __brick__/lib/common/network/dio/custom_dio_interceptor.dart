import '../../imports/imports.dart';

class CustomDioInterceptor extends Interceptor {
  final bool requestHeader;
  final bool requestBody;
  final bool responseHeader;
  final bool responseBody;
  final bool showError;

  CustomDioInterceptor({
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = true,
    this.responseBody = true,
    this.showError = true,
  });

  /// HTTP method → outbound request color (read / write / destructive).
  static String _colorForMethod(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
      case 'HEAD':
        return LogColors.cyan;
      case 'POST':
        return LogColors.green;
      case 'PUT':
        return LogColors.yellow;
      case 'PATCH':
        return LogColors.orange;
      case 'DELETE':
        return LogColors.red;
      case 'OPTIONS':
        return LogColors.blue;
      default:
        return LogColors.gray;
    }
  }

  /// Status code → response outcome (success / redirect / client / server).
  static String _colorForStatusCode(int? statusCode) {
    if (statusCode == null) {
      return LogColors.gray;
    }
    if (statusCode >= 100 && statusCode < 200) {
      return LogColors.blue;
    }
    if (statusCode >= 200 && statusCode < 300) {
      return LogColors.brightGreen;
    }
    if (statusCode >= 300 && statusCode < 400) {
      return LogColors.cyan;
    }
    if (statusCode >= 400 && statusCode < 500) {
      return LogColors.orange;
    }
    if (statusCode >= 500) {
      return LogColors.red;
    }
    return LogColors.magenta;
  }

  /// Error path: network/timeout vs client (4xx) vs server (5xx).
  static String _colorForError(DioException err) {
    final code = err.response?.statusCode;
    if (code != null) {
      if (code >= 400 && code < 500) {
        return LogColors.orange;
      }
      if (code >= 500) {
        return LogColors.red;
      }
    }
    switch (err.type) {
      case DioExceptionType.cancel:
        return LogColors.yellow;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return LogColors.brightRed;
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        return LogColors.red;
      default:
        return LogColors.red;
    }
  }

  void _printBox(String title, String message, String color) {
    debugPrint(
      '$color╔══════════════════════════════════════════════════════════════════════════════════════════',
    );
    debugPrint('$color║ $title');
    debugPrint(
      '$color╟──────────────────────────────────────────────────────────────────────────────────────────',
    );
    for (final line in message.trim().split('\n')) {
      debugPrint('$color║ $line');
    }
    debugPrint(
      '$color╚══════════════════════════════════════════════════════════════════════════════════════════',
    );
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method;
    final methodColor = _colorForMethod(method);
    String message = '📤 [REQUEST] $method => ${options.uri}\n';

    if (requestHeader) {
      message += 'Request Headers:\n';
      options.headers.forEach((key, value) {
        if (value is List) {
          for (final item in value) {
            message += '  $key: $item\n';
          }
        } else {
          message += '  $key: $value\n';
        }
      });
    }

    if (requestBody) {
      final data = options.data;
      if (data is FormData) {
        message += 'Request Body:{\n';
        for (final field in data.fields) {
          message += '${field.key}: ${field.value}\n';
        }
        for (final file in data.files) {
          message += '${file.key}: ${file.value}\n';
        }
        message += '}\n';
      } else {
        message += 'Request Body: ${options.data}\n';
      }
    }

    _printBox('📤 REQUEST [$method]', message, methodColor);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String message =
        '📥 [RESPONSE] ${response.statusCode} => ${response.requestOptions.uri}\n';

    if (responseHeader) {
      message += 'Response Headers:\n';
      response.headers.forEach((key, value) {
        for (final item in value) {
          message += '  $key: $item\n';
        }
      });
    }

    if (responseBody) {
      message += 'Response Data: ${response.data}\n';
    }

    _printBox(
      '📥 RESPONSE [${response.statusCode}]',
      message,
      _colorForStatusCode(response.statusCode),
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!showError) {
      return handler.next(err);
    }

    String message = '❌ [ERROR] ${err.requestOptions.uri}\n';

    if (err.response?.statusCode != null) {
      message += 'Status: ${err.response?.statusCode}\n';
    }

    if (err.response?.data != null) {
      message += 'Response: ${err.response?.data}\n';
    }

    if (err.message != null) {
      message += 'Message: ${err.message}\n';
    }

    _printBox('❌ ERROR', message, _colorForError(err));
    handler.next(err);
  }
}
