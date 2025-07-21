import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/health_log.dart';
import '../providers/logs_provider.dart';

class HealthLogsScreen extends StatefulWidget {
  const HealthLogsScreen({super.key});

  @override
  State<HealthLogsScreen> createState() => _HealthLogsScreenState();
}

class _HealthLogsScreenState extends State<HealthLogsScreen> {
  final _controller = TextEditingController();

  void _addLog(BuildContext context) {
    final note = _controller.text.trim();
    if (note.isNotEmpty) {
      final now = DateTime.now();
      final log = HealthLog(
        id: const Uuid().v4(),
        title: note,
        description: note,
        date: now.toString().substring(0, 10),
        time: now.toString().substring(11, 16),
      );
      Provider.of<LogsProvider>(context, listen: false).addLog(log);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final logs = Provider.of<LogsProvider>(context).logs;

    return Scaffold(
      appBar: AppBar(title: const Text('Health Logs')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Write your health note...',
                suffixIcon: Icon(Icons.note_add),
              ),
              onSubmitted: (_) => _addLog(context),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _addLog(context),
              child: const Text('Add Entry'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: logs.isEmpty
                  ? const Center(child: Text('No logs yet.'))
                  : ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return Card(
                          child: ListTile(
                            title: Text(log.title),
                            subtitle: Text('${log.date} ${log.time}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Provider.of<LogsProvider>(
                                  context,
                                  listen: false,
                                ).deleteLog(log.id);
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
