import 'package:url_launcher/url_launcher.dart';

class MapService {
  static openMapForSearch(String searchQuery) async {
    String googleUrl = 'https://www.google.com/maps/search/$searchQuery';
    final Uri _url = Uri.parse(googleUrl);
    await launchUrl(_url);
  }
}
