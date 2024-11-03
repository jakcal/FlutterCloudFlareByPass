import 'package:cookies_spoofer/constants.dart';
import 'package:cookies_spoofer/utils/checkCF.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CloudflareVerificationScreen extends StatefulWidget {
  @override
  _CloudflareVerificationScreenState createState() =>
      _CloudflareVerificationScreenState();
}

class _CloudflareVerificationScreenState
    extends State<CloudflareVerificationScreen> {
  final cookieManager = CookieManager();

  @override
  void initState() {
    super.initState();
    _clearCookies();
  }

  Future<void> _clearCookies() async {
    await cookieManager.deleteAllCookies();
  }

  Future<void> _storeCookies() async {
    List<Cookie> cookies = await cookieManager.getCookies(url: WebUri(HOST));

    for (var cookie in cookies) {
      print('Storing cookie: ${cookie.name}=${cookie.value}');
      await storage.write(key: cookie.name, value: cookie.value);
    }
  }

  void _onPageFinished(InAppWebViewController controller, WebUri? url) async {
    // Here, add checks to confirm if the challenge is complete
    // Optionally, store cookies immediately after completion
    print('Page finished loading: ${url?.toString()}');
    String? html = await controller.getHtml();
    if (html != null &&
        (html.contains("google-site-verification") ||
            html.contains("og:title"))) {
      print('Challenge completed, Storing cookies');

      await _storeCookies();
      Navigator.pushReplacementNamed(context, '/home');
    }
    // await _storeCookies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(HOST)),
        onLoadStop: _onPageFinished,
        initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            useWideViewPort: true,
            domStorageEnabled: true,
            userAgent: USERAGENT),
      ),
    );
  }
}
