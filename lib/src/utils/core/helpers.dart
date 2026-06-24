
import 'package:url_launcher/url_launcher.dart';

Future<void> sendingSMS(String phoneNumber) async {
      Uri url = Uri(
        scheme: 'sms',
        path: '+51$phoneNumber',
      );
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch $url');
      }
}

Future<void> calling(String phoneNumber) async {
      Uri url = Uri(
        scheme: 'tel',
        path: "+51$phoneNumber",
      );
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch $url');
      }
}