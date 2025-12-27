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

  final String _cyan = '\x1B[36m';
  final String _green = '\x1B[32m';
  final String _yellow = '\x1B[33m';
  final String _red = '\x1B[31m';
  final String _magenta = '\x1B[35m';

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
    String methodColor;

    if (method == 'GET') {
      methodColor = _cyan;
    } else if (method == 'POST') {
      methodColor = _green;
    } else if (method == 'PUT') {
      methodColor = _yellow;
    } else if (method == 'DELETE') {
      methodColor = _red;
    } else {
      methodColor = '\x1B[37m';
    }
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

    _printBox('📥 RESPONSE [${response.statusCode}]', message, _magenta);
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

    _printBox('❌ ERROR', message, _red);
    handler.next(err);
  }
}
