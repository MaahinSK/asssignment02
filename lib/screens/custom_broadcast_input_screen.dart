import 'package:flutter/material.dart';
import 'custom_broadcast_receiver_screen.dart';

class CustomBroadcastInputScreen extends StatefulWidget {
  const CustomBroadcastInputScreen({super.key});

  @override
  State<CustomBroadcastInputScreen> createState() => _CustomBroadcastInputScreenState();
}

class _CustomBroadcastInputScreenState extends State<CustomBroadcastInputScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Broadcast – Input'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Enter a message to broadcast:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
                hintText: 'Type your message here...',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () {
                if (_controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a message!')),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CustomBroadcastReceiverScreen(
                      message: _controller.text.trim(),
                    ),
                  ),
                );
              },
              child: const Text('Send Broadcast', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}