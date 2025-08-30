import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../models/bmi_result.dart';

class StorageService {
  static const String _resultsKey = 'bmi_results';

  static Future<void> saveResult(BMIResult result) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final results = await getResults();
      results.insert(0, result); // Add to beginning of list
      
      // Keep only last 50 results
      if (results.length > 50) {
        results.removeRange(50, results.length);
      }
      
      final jsonList = results.map((r) => r.toJson()).toList();
      await prefs.setString(_resultsKey, jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error saving result: $e');
    }
  }

  static Future<List<BMIResult>> getResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_resultsKey);
      
      if (jsonString == null) return [];
      
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => BMIResult.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error loading results: $e');
      return [];
    }
  }

  static Future<void> deleteResult(int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final results = await getResults();
      
      if (index >= 0 && index < results.length) {
        results.removeAt(index);
        final jsonList = results.map((r) => r.toJson()).toList();
        await prefs.setString(_resultsKey, jsonEncode(jsonList));
      }
    } catch (e) {
      debugPrint('Error deleting result: $e');
    }
  }

  static Future<void> clearAllResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_resultsKey);
    } catch (e) {
      debugPrint('Error clearing results: $e');
    }
  }
}
