import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();

  // Save methods
  static Future<void> saveName(String name) async {
    final prefs = await _instance;
    await prefs.setString('name', name);
  }

  static Future<void> saveAge(int age) async {
    final prefs = await _instance;
    await prefs.setInt('age', age);
  }

  static Future<void> saveWeight(double weight) async {
    final prefs = await _instance;
    await prefs.setDouble('weight', weight);
  }

  static Future<void> saveHeight(double height) async {
    final prefs = await _instance;
    await prefs.setDouble('height', height);
  }

  // Get methods
  static Future<String> getName() async {
    final prefs = await _instance;
    return prefs.getString('name') ?? '';
  }

  static Future<int> getAge() async {
    final prefs = await _instance;
    return prefs.getInt('age') ?? 0;
  }

  static Future<double> getWeight() async {
    final prefs = await _instance;
    return prefs.getDouble('weight') ?? 0;
  }

  static Future<double> getHeight() async {
    final prefs = await _instance;
    return prefs.getDouble('height') ?? 0;
  }

  // Clear all data
  static Future<void> clearAll() async {
    final prefs = await _instance;
    await prefs.clear();
  }
}
