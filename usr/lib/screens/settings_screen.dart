import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _ttsEnabled = true;
  String _serverUrl = 'http://localhost:8000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Text-to-Speech (TTS)'),
            subtitle: const Text('Read AI responses aloud'),
            value: _ttsEnabled,
            onChanged: (val) {
              setState(() {
                _ttsEnabled = val;
              });
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Server Connection'),
            subtitle: Text(_serverUrl),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Future: Edit server URL
              },
            ),
          ),
        ],
      ),
    );
  }
}