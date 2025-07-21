import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/health_log.dart';

class LogsProvider extends ChangeNotifier {
  final List<HealthLog> _logs = [];

  List<HealthLog> get logs => _logs;

  LogsProvider() {
    loadLogs();
  }

  Future<void> loadLogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('health_logs');
    if (data != null) {
      List decoded = jsonDecode(data);
      _logs.clear();
      _logs.addAll(decoded.map((e) => HealthLog.fromJson(e)));
      notifyListeners();
    }
  }

  Future<void> saveLogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode(_logs.map((e) => e.toJson()).toList());
    await prefs.setString('health_logs', data);
  }

  void addLog(HealthLog log) {
    _logs.add(log);
    saveLogs();
    notifyListeners();
  }

  void deleteLog(String id) {
    _logs.removeWhere((l) => l.id == id);
    saveLogs();
    notifyListeners();
  }
}
