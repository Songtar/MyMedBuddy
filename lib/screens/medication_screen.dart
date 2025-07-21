import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/medication.dart';
import '../providers/medication_provider.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _dosageController = TextEditingController();

  void _addMedication(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<MedicationProvider>(context, listen: false);
      provider.addMedication(Medication(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        time: _timeController.text.trim(),
        dosage: _dosageController.text.trim(),
      ));
      _nameController.clear();
      _timeController.clear();
      _dosageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final meds = Provider.of<MedicationProvider>(context).medications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Schedule'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Medication',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Medication Name'),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(labelText: 'Time (e.g. 8:00 AM)'),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dosageController,
                    decoration: const InputDecoration(labelText: 'Dosage'),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _addMedication(context),
                    child: const Text('Add Medication'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Scheduled Medications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: meds.isEmpty
                  ? const Center(child: Text('No medications added yet.'))
                  : ListView.builder(
                      itemCount: meds.length,
                      itemBuilder: (context, index) {
                        final med = meds[index];
                        return Card(
                          child: ListTile(
                            title: Text('${med.name} (${med.dosage})'),
                            subtitle: Text('Time: ${med.time}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Provider.of<MedicationProvider>(context, listen: false)
                                    .deleteMedication(med.id);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
