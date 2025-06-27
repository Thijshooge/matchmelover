import 'package:flutter/material.dart';

class ChatMeldingWidget extends StatelessWidget {
  const ChatMeldingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Melding')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Melding Instellingen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Ontvang meldingen'),
              value: true,
              onChanged: (bool value) {
                // Handle switch toggle
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Geluid'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle geluid instellingen
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Trillen'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle trillen instellingen
              },
            ),
          ],
        ),
      ),
    );
  }
}
