import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/appointment.dart';
import '../providers/appointment_provider.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _doctorController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  void _addAppointment(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<AppointmentProvider>(context, listen: false);
      provider.addAppointment(Appointment(
        id: const Uuid().v4(),
        doctor: _doctorController.text,
        date: _dateController.text,
        time: _timeController.text,
      ));
      _doctorController.clear();
      _dateController.clear();
      _timeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<AppointmentProvider>(context).appointments;

    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _doctorController,
                    decoration: const InputDecoration(labelText: 'Doctor / Clinic'),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(labelText: 'Date (e.g. July 25)'),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(labelText: 'Time (e.g. 10:00 AM)'),
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _addAppointment(context),
                    child: const Text('Add Appointment'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: appointments.isEmpty
                  ? const Center(child: Text('No appointments yet.'))
                  : ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        final appt = appointments[index];
                        return Card(
                          child: ListTile(
                            title: Text(appt.doctor),
                            subtitle: Text('${appt.date} at ${appt.time}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Provider.of<AppointmentProvider>(context, listen: false)
                                    .deleteAppointment(appt.id);
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
