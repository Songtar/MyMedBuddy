import 'package:flutter/material.dart';
import '../services/shared_prefs_service.dart';
import '../../main.dart'; // Import darkModeNotifier

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _conditionController = TextEditingController();
  bool _editing = false;
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  String _logReminderTime = "08:00";

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadPreferences();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProfile();
    _loadPreferences();
  }

  Future<void> _loadProfile() async {
    final user = await SharedPrefsService.getUserData();
    setState(() {
      _nameController.text = user['username'];
      _ageController.text = user['age'].toString();
      _conditionController.text = user['condition'];
      _editing = false;
    });
  }

  Future<void> _loadPreferences() async {
    final isDark = await SharedPrefsService.getDarkMode();
    final notif = await SharedPrefsService.getNotificationsEnabled();
    final reminder = await SharedPrefsService.getLogReminderTime();
    setState(() {
      _isDarkMode = isDark;
      _notificationsEnabled = notif;
      _logReminderTime = reminder;
    });
  }

  Future<void> _saveProfile() async {
    await SharedPrefsService.saveUserData(
      name: _nameController.text.trim(),
      age: int.tryParse(_ageController.text.trim()) ?? 0,
      condition: _conditionController.text.trim(),
    );
    setState(() {
      _editing = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated!')));
    }
  }

  Future<void> _resetProfile() async {
    await SharedPrefsService.clearUserData();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/onboarding',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          !_editing
              ? IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _editing = true;
                    });
                  },
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter your name' : null,
                enabled: _editing,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter your age' : null,
                enabled: _editing,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _conditionController,
                decoration: const InputDecoration(labelText: 'Condition'),
                enabled: _editing,
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: _isDarkMode,
                onChanged: (val) async {
                  setState(() => _isDarkMode = val);
                  await SharedPrefsService.setDarkMode(val);
                  darkModeNotifier.value = val; // Update app theme
                },
              ),
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: _notificationsEnabled,
                onChanged: (val) async {
                  setState(() => _notificationsEnabled = val);
                  await SharedPrefsService.setNotificationsEnabled(val);
                },
              ),
              ListTile(
                title: const Text('Daily Log Reminder'),
                subtitle: Text(_logReminderTime),
                trailing: const Icon(Icons.alarm),
                onTap: () async {
                  final timeParts = _logReminderTime.split(":");
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                      hour: int.parse(timeParts[0]),
                      minute: int.parse(timeParts[1]),
                    ),
                  );
                  if (picked != null) {
                    final formatted =
                        picked.hour.toString().padLeft(2, '0') +
                        ':' +
                        picked.minute.toString().padLeft(2, '0');
                    setState(() => _logReminderTime = formatted);
                    await SharedPrefsService.setLogReminderTime(formatted);
                  }
                },
              ),
              const SizedBox(height: 20),
              _editing
                  ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveProfile();
                        }
                      },
                      child: const Text('Save Profile'),
                    )
                  : Container(),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _resetProfile,
                icon: const Icon(Icons.restart_alt),
                label: const Text('Reset App / Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
