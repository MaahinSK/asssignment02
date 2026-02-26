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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = EdgeInsets.symmetric(
      horizontal: screenWidth * 0.05,
      vertical: screenHeight * 0.03,
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Broadcast Operation:',
              style: TextStyle(
                fontSize: screenWidth * 0.05, // scales with screen width
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

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
                      child: Text(
                        value,
                        style: TextStyle(fontSize: screenWidth * 0.04),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() => _selectedOption = newValue!);
                  },
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Proceed Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
              child: Text(
                'Proceed',
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
            ),
          ],
        ),
      ),
    );
  }
}