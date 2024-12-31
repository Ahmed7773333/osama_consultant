// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:osama_consul/core/utils/get_itt.dart';
// import 'package:osama_consul/features/user/MyRequests/presentation/cubit/myrequests_cubit.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../../../../user/MyRequests/presentation/pages/success_page.dart';

// class BuyConsultants extends StatefulWidget {
//   const BuyConsultants({super.key});

//   @override
//   State<BuyConsultants> createState() => _BuyConsultantsState();
// }

// class _BuyConsultantsState extends State<BuyConsultants> {
//   int consultantsCounter = 1;

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context)!;

//     return BlocProvider(
//       create: (context) => sl<MyrequestsCubit>()..getAuthToken(false),
//       child: BlocConsumer<MyrequestsCubit, MyrequestsState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           if (MyrequestsCubit.get(context).requestToken.isEmpty)
//             return Scaffold();
//           else {
//             final WebViewController _controller = WebViewController()
//               ..setJavaScriptMode(JavaScriptMode.unrestricted)
//               ..setBackgroundColor(const Color(0x00000000))
//               ..setNavigationDelegate(
//                 NavigationDelegate(
//                   onProgress: (int progress) {
//                     // Update loading bar.
//                     debugPrint('WebView is loading (progress : $progress%)');
//                   },
//                   onPageStarted: (String url) {
//                     debugPrint('Page started loading: $url');
//                   },
//                   onPageFinished: (String url) async {
//                     debugPrint('Page finished loading: $url');
//                     Uri uri = Uri.parse(url);
//                     debugPrint(uri.queryParameters.length.toString());
//                     if (uri.queryParameters['txn_response_code'] == 'ERROR') {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (c) => const PaymentDeclinedPage()));
//                     }
//                     if (uri.queryParameters.length == 35) {
//                       try {
//                         debugPrint(uri.queryParameters['success']);
//                         if (uri.queryParameters['success'] == 'false' ||
//                             uri.queryParameters['txn_response_code'] ==
//                                 'ERROR') {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (c) => const PaymentDeclinedPage()));
//                         } else if (uri.queryParameters['success'] == 'true') {
//                           Map<String, dynamic> queryParams =
//                               Map<String, dynamic>.from(uri.queryParameters);

//                           if (MyrequestsCubit.get(context).trg < 1) {
//                             await MyrequestsCubit.get(context)
//                                 .storeConusltant(int.parse(queryParams['id']));
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (c) => PaymentCompletedPage(
//                                         MyrequestsCubit.get(context))));
//                           }
//                         }
//                       } catch (e) {
//                         debugPrint(e.toString());
//                       }
//                     }
//                   },
//                   onWebResourceError: (WebResourceError error) {
//                     debugPrint('Error occurred: $error');
//                   },
//                   onNavigationRequest: (NavigationRequest request) {
//                     if (request.url.startsWith('https://www.youtube.com/')) {
//                       debugPrint('blocking navigation to $request}');
//                       return NavigationDecision.prevent;
//                     }
//                     debugPrint('allowing navigation to $request');
//                     return NavigationDecision.navigate;
//                   },
//                 ),
//               )
//               ..loadRequest(
//                 Uri.parse(
//                     "https://accept.paymob.com/api/acceptance/iframes/854679?payment_token=${MyrequestsCubit.get(context).requestToken}"),
//               );
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text(localizations.visaPayment),
//               ),
//               body: WebViewWidget(controller: _controller),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
