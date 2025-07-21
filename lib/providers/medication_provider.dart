import 'package:flutter/material.dart';
import '../models/medication.dart';

class MedicationProvider extends ChangeNotifier {
  final List<Medication> _medications = [];

  List<Medication> get medications => _medications;

  void addMedication(Medication med) {
    _medications.add(med);
    notifyListeners();
  }

  void deleteMedication(String id) {
    _medications.removeWhere((m) => m.id == id);
    notifyListeners();
  }
}
