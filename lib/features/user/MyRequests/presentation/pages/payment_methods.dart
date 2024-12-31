// import 'package:flutter/material.dart';
// import 'package:osama_consul/config/app_routes.dart';

// class ChoosePaymentMethodScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Choose Payment Method"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             PaymentMethodCard(
//               icon: Icons.account_balance_wallet,
//               title: "Pay with Wallet",
//               onTap: () {
//                 Navigator.pushNamed(context, Routes.);
//               },
//             ),
//             SizedBox(height: 16),
//             PaymentMethodCard(
//               icon: Icons.credit_card,
//               title: "Pay with Visa",
//               onTap: () {
//                 // Call the Visa payment method
//                 print("Visa Payment Selected");
//                 // Add your payment function here
//               },
//             ),
//             SizedBox(height: 16),
//             PaymentMethodCard(
//               icon: Icons.payment,
//               title: "Pay with Credit Card",
//               onTap: () {
//                 Navigator.pushNamed(context, Routes.cridetPay);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PaymentMethodCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;

//   const PaymentMethodCard({
//     Key? key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//           child: Row(
//             children: [
//               Icon(icon, size: 40, color: Theme.of(context).primaryColor),
//               SizedBox(width: 16),
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
