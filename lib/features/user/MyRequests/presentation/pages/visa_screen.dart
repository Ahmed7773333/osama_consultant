import 'package:flutter/material.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/pages/success_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen(this.cubit, {super.key});
  final MyrequestsCubit cubit;

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Instantiate the WebViewController with settings and navigation delegate
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            Uri uri = Uri.parse(url);
            if (uri.queryParameters.length == 35) {
              try {
                debugPrint(uri.queryParameters['success']);
                if (uri.queryParameters['success'] == 'true') {
                  Map<String, dynamic> queryParams =
                      Map<String, dynamic>.from(uri.queryParameters);
                  debugPrint('$queryParams');
                  queryParams['meeting_id'] = 6;
                  if (widget.cubit.trg < 1) {
                    widget.cubit.sendTransaction(queryParams);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const PaymentCompletedPage()));
                  }
                } else if (uri.queryParameters['success'] == 'false') {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const PaymentDeclinedPage()));
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error occurred: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
            "https://accept.paymob.com/api/acceptance/iframes/854679?payment_token=${widget.cubit.requestToken}"),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Payment'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
