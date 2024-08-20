import 'package:flutter/material.dart';
import 'package:osama_consul/features/user/MyRequests/presentation/pages/success_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen(this.cubit, this.meetingId, {super.key});
  final MyrequestsCubit cubit;
  final int meetingId;

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
            debugPrint(uri.queryParameters.length.toString());
            if (uri.queryParameters['txn_response_code'] == 'ERROR') {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const PaymentDeclinedPage()));
            }
            if (uri.queryParameters.length == 35) {
              try {
                debugPrint(uri.queryParameters['success']);
                if (uri.queryParameters['success'] == 'false' ||
                    uri.queryParameters['txn_response_code'] == 'ERROR') {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (c) => const PaymentDeclinedPage()));
                } else if (uri.queryParameters['success'] == 'true') {
                  Map<String, dynamic> queryParams =
                      Map<String, dynamic>.from(uri.queryParameters);
                  debugPrint('$queryParams');
                  queryParams['meeting_id'] = widget.meetingId;
                  if (widget.cubit.trg < 1) {
                    widget.cubit.sendMeetingTransaction(queryParams);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (c) =>
                                PaymentCompletedPage(widget.cubit)));
                  }
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.visaPayment),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
