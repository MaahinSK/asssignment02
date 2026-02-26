import 'package:flutter/material.dart';
import 'screens/broadcast_receiver_screen.dart';
import 'screens/image_scale_screen.dart';
import 'screens/video_screen.dart';
import 'screens/audio_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSE 489 Assignment 2',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    BroadcastReceiverScreen(),
    ImageScaleScreen(),
    VideoScreen(),
    AudioScreen(),
  ];

  final List<String> _titles = [
    'A. Broadcast Receiver',
    'B. Image Scale',
    'C. Video Player',
    'D. Audio Player',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                'CSE 489 – Assignment 2\nDrawer Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            _buildDrawerItem(context, 0, Icons.broadcast_on_home, 'A. Broadcast Receiver'),
            _buildDrawerItem(context, 1, Icons.image, 'B. Image Scale'),
            _buildDrawerItem(context, 2, Icons.videocam, 'C. Video'),
            _buildDrawerItem(context, 3, Icons.audiotrack, 'D. Audio'),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildDrawerItem(BuildContext context, int index, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: _selectedIndex == index ? Colors.indigo : Colors.grey),
      title: Text(title,
          style: TextStyle(
              fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal)),
      selected: _selectedIndex == index,
      onTap: () {
        setState(() => _selectedIndex = index);
        Navigator.pop(context); // Close drawer
      },
    );
  }
}