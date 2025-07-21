import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/appointment.dart';

class AppointmentProvider extends ChangeNotifier {
  final List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  AppointmentProvider() {
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('appointments');
    if (data != null) {
      List decoded = jsonDecode(data);
      _appointments.clear();
      _appointments.addAll(decoded.map((e) => Appointment.fromJson(e)));
      notifyListeners();
    }
  }

  Future<void> saveAppointments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = jsonEncode(_appointments.map((e) => e.toJson()).toList());
    await prefs.setString('appointments', data);
  }

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    saveAppointments();
    notifyListeners();
  }

  void deleteAppointment(String id) {
    _appointments.removeWhere((a) => a.id == id);
    saveAppointments();
    notifyListeners();
  }
}
