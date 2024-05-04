// import 'package:crocs_club/domain/core/constants/constants.dart';
// import 'package:crocs_club/domain/utils/widgets/textwidgets.dart';
// import 'package:flutter/material.dart';

// class WalletAmountWidget extends StatelessWidget {
//   const WalletAmountWidget({
//     super.key,
//     required this.walletAmount,
//   });
//   final String walletAmount;
//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//       Card(
//         elevation: 4,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SubHeadingTextWidget(
//                 title: 'Current Balance',
//                 textColor: kDarkGreyColour,
//                 textsize: 18,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 walletAmount, // Dynamic wallet amount
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: kGreenColour,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ]);
//   }
// }
