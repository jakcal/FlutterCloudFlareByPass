import 'package:cookies_spoofer/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

final storage = FlutterSecureStorage();

Future<bool> checkCloudflareProtection() async {
  final url = Uri.parse(HOST);

  try {
    final request = await HttpClient().getUrl(url);

    // Attach cookies from secure storage
    final allCookies = await storage.readAll();
    final cookieHeader =
        allCookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
    print('Rquesting with cookies: $cookieHeader');
    request.headers.set('Cookie', cookieHeader);

    request.headers.set('User-Agent', USERAGENT);
    final response = await request.close();

    print('Response Status: ${response.statusCode}');
    if (response.statusCode == 403 || response.statusCode == 503) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  } catch (e) {
    return Future.value(false);
  }
}
