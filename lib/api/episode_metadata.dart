import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Iterable<Map<String, dynamic>>> getEpisodeInfo(int anilistId) async {
  final String baseURL = 'https://api.ani.zip/mappings';
  var response = await http.get(Uri.parse('$baseURL?anilist_id=$anilistId'));
  if (response.statusCode == 200) {
    var result = jsonDecode(response.body)['episodes'] as Map<String, dynamic>;
    return result.values
        .where((el) => double.tryParse(el['episode']) != null)
        .map((el) => el as Map<String, dynamic>);
  } else {
    return [];
  }
}
