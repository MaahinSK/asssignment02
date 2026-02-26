import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  final Battery _battery = Battery();
  int _batteryLevel = 0;
  BatteryState _batteryState = BatteryState.unknown;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getBatteryInfo();
  }

  Future<void> _getBatteryInfo() async {
    final level = await _battery.batteryLevel;
    final state = await _battery.batteryState;
    setState(() {
      _batteryLevel = level;
      _batteryState = state;
      _loading = false;
    });
  }

  String _getBatteryStateText() {
    switch (_batteryState) {
      case BatteryState.charging:
        return 'Charging ⚡';
      case BatteryState.discharging:
        return 'Discharging';
      case BatteryState.full:
        return 'Full 🔋';
      default:
        return 'Unknown';
    }
  }

  Color _getBatteryColor() {
    if (_batteryLevel > 50) return Colors.green;
    if (_batteryLevel > 20) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Receiver'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: _loading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.battery_full,
                  size: screenWidth * 0.2,
                  color: _getBatteryColor(),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '$_batteryLevel%',
                  style: TextStyle(
                    fontSize: screenWidth * 0.15,
                    fontWeight: FontWeight.bold,
                    color: _getBatteryColor(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Status: ${_getBatteryStateText()}',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Battery bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _batteryLevel / 100,
                    minHeight: screenHeight * 0.02,
                    backgroundColor: Colors.grey.shade300,
                    color: _getBatteryColor(),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton.icon(
                  onPressed: _getBatteryInfo,
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    'Refresh',
                    style: TextStyle(fontSize: screenWidth * 0.04),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.015,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}