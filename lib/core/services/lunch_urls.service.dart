// import 'package:url_launcher/url_launcher.dart';
//
// import '../../main.dart';
//
// class LaunchUrlsService {
//   /// Launch a website or general URL
//   static Future<void> openLink(String url) async {
//     final uri = Uri.parse(url);
//     try {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);00000000000000['pp
//     } catch (e) {
//       logger.e("❌ Could not launch $url , $e");
//     }
//   }
//
//   /// Launch email app with prefilled fields
//   static Future<void> sendEmail({
//     required String toEmail,
//     String subject = '',
//     String body = '',
//   }) async {
//     final uri = Uri(
//       scheme: 'mailto',
//       path: toEmail,
//       queryParameters: {'subject': subject, 'body': body},
//     );
//     try {
//       await launchUrl(uri);
//     } catch (e) {
//       logger.e("❌ Could not launch email to $toEmail");
//     }
//   }
//
//   /// Launch phone dialer
//   static Future<void> callPhone(String phoneNumber) async {
//     final uri = Uri(scheme: 'tel', path: phoneNumber);
//     try {
//       await launchUrl(uri);
//     } catch (e) {
//       logger.e("❌ Could not call $phoneNumber");
//     }
//   }
//
//   /// Launch SMS app
//   static Future<void> sendSms(String phoneNumber, {String? message}) async {
//     final uri = Uri(
//       scheme: 'sms',
//       path: phoneNumber,
//       queryParameters: message != null ? {'body': message} : null,
//     );
//     try {
//       await launchUrl(uri);
//     } catch (e) {
//       logger.e("❌ Could not send SMS to $phoneNumber");
//     }
//   }
//
//   /// Launch WhatsApp chat
//   static Future<void> openWhatsApp({
//     required String phoneNumber,
//     String message = '',
//   }) async {
//     final uri = Uri.parse(
//       'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
//     );
//     try {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } catch (e) {
//       logger.e("❌ Could not open WhatsApp for $phoneNumber");
//     }
//   }
// }
