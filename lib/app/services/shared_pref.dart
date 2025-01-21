
import 'package:shared_preferences/shared_preferences.dart';

Future<void> cacheApiResponse(String key, String response) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, response); // Save response
}

Future<String?> getCachedApiResponse(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key); // Retrieve cached response
}