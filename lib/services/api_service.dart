import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = 'https://publicapis.dev/api/health';

  static Future<List<String>> fetchHealthTips() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Adjust based on actual API structure
      List<String> tips = data.map((item) {
        if (item is Map && item.containsKey('description')) {
          return item['description'] as String;
        } else if (item is String) {
          return item;
        } else {
          return 'Unknown tip format';
        }
      }).toList();

      return tips;
    } else {
      throw Exception('Failed to load health tips');
    }
  }
}
