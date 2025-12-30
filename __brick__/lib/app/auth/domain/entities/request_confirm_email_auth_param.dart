class RequestConfirmEmailAuthParam {
  final RequestConfirmEmailRequestParam? request;

  RequestConfirmEmailAuthParam({
    this.request,
  });

  Map<String, dynamic> toJson() {
    return {
      'request': request?.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}
class RequestConfirmEmailRequestParam {
  Map<String, dynamic> toJson() {
    return {
    };
  }
}
