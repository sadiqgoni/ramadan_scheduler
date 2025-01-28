import 'package:flutter/material.dart';
import 'package:ramadan_scheduler/screens/imam_management_screen.dart';
import 'package:ramadan_scheduler/screens/login_screen.dart';
import 'package:ramadan_scheduler/screens/mosque_list_screen.dart';
import 'package:ramadan_scheduler/screens/notifications_screen.dart';
import 'package:ramadan_scheduler/screens/prayer_schedule_screen.dart';
import 'package:ramadan_scheduler/screens/settings_screen.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  UserModel? currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // TODO: Implement user data loading
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramadan Prayer Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    currentUser?.name ?? 'User',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    currentUser?.email ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.mosque),
              title: const Text('Mosques'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MosqueListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Prayer Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrayerScheduleScreen(),
                  ),
                );
              },
            ),
            if (currentUser?.role == UserRole.grandImam)
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Manage Imams'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImamManagementScreen(),
                    ),
                  );
                },
              ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _buildHomeContent(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHomeContent() {
    // TODO: Implement different views based on user role
    return const Center(
      child: Text('Welcome to Ramadan Prayer Schedule App'),
    );
  }

  Widget? _buildFloatingActionButton() {
    if (currentUser?.role == UserRole.grandImam) {
      return FloatingActionButton(
        onPressed: () {
          // TODO: Implement schedule creation
        },
        child: const Icon(Icons.add),
      );
    }
    return null;
  }
}
