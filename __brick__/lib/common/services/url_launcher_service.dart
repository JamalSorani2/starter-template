import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  /// Launch a normal URL (http/https)
  Future<void> launchUrlString(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      debugPrint('Invalid URL: $url');
      return;
    }
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  /// Open email client
  Future<void> launchEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: [
        if (subject != null) 'subject=${Uri.encodeComponent(subject)}',
        if (body != null) 'body=${Uri.encodeComponent(body)}',
      ].join('&'),
    );
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch email: $email');
    }
  }

  /// Open phone dialer
  Future<void> launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch phone: $phone');
    }
  }

  /// Open SMS app
  Future<void> launchSms(String phone, {String? body}) async {
    final uri = Uri(
      scheme: 'sms',
      path: phone,
      query: body != null ? 'body=${Uri.encodeComponent(body)}' : null,
    );
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch sms: $phone');
    }
  }

  /// Open map with coordinates or address
  Future<void> launchMap(String query) async {
    final uri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: '/maps/search/',
      queryParameters: {'api': '1', 'query': query},
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch map: $query');
    }
  }
}
