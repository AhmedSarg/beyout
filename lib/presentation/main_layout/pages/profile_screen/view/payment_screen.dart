// import 'package:flutter/material.dart';
// import 'package:temp_house/presentation/common/widget/main_button.dart';
// import 'package:temp_house/presentation/main_layout/pages/profile_screen/view/widgets/payment_screen_details.dart';
// import 'package:temp_house/presentation/resources/color_manager.dart';
// import 'package:temp_house/presentation/resources/routes_manager.dart';
// import 'package:temp_house/presentation/resources/text_styles.dart';
//
// import '../../../../resources/assets_manager.dart';
// import '../../../../resources/values_manager.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   List<String> cards = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment Details'),
//       ),
//       body: Column(
//         children: [
//           // Existing UI code
//           // Display existing cards here
//
//           Spacer(),
//           MainButton(
//             backgroundColor: ColorManager.white,
//             text: 'Add New Card',
//             textStyle: AppTextStyles.PaymentBtnTextStyle(context),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PaymentScreenDetails(
//                     onSave: (cardNumber, expiryDate, cvv) {
//                       setState(() {
//                         cards.add('$cardNumber - $expiryDate - $cvv');
//                       });
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: AppSize.s30),
//         ],
//       ),
//     );
//   }
// }
