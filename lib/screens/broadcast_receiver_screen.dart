import 'package:flutter/material.dart';
import 'custom_broadcast_input_screen.dart';
import 'battery_screen.dart';

class BroadcastReceiverScreen extends StatefulWidget {
  const BroadcastReceiverScreen({super.key});

  @override
  State<BroadcastReceiverScreen> createState() => _BroadcastReceiverScreenState();
}

class _BroadcastReceiverScreenState extends State<BroadcastReceiverScreen> {
  String _selectedOption = 'Custom Broadcast Receiver';

  final List<String> _options = [
    'Custom Broadcast Receiver',
    'System Battery Notification Receiver',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select Broadcast Operation:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Spinner (Dropdown)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedOption,
                isExpanded: true,
                items: _options.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() => _selectedOption = newValue!);
                },
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Proceed Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              if (_selectedOption == 'Custom Broadcast Receiver') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CustomBroadcastInputScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BatteryScreen()),
                );
              }
            },
            child: const Text('Proceed', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}