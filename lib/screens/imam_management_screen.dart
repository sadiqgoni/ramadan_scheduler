import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ImamManagementScreen extends StatefulWidget {
  const ImamManagementScreen({super.key});

  @override
  _ImamManagementScreenState createState() => _ImamManagementScreenState();
}

class _ImamManagementScreenState extends State<ImamManagementScreen> {
  List<UserModel> _imams = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImams();
  }

  Future<void> _loadImams() async {
    // TODO: Implement loading imams from Firebase
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Imams'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddImamDialog(context),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildImamList(),
    );
  }

  Widget _buildImamList() {
    if (_imams.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No imams registered yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _imams.length,
      itemBuilder: (context, index) {
        final imam = _imams[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(
                imam.name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(imam.name),
            subtitle: Text(imam.email),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: Text('View Schedule'),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 'view':
                    _viewImamSchedule(imam);
                    break;
                  case 'edit':
                    _showEditImamDialog(context, imam);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, imam);
                    break;
                }
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAddImamDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Imam'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement add imam functionality
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditImamDialog(BuildContext context, UserModel imam) async {
    final nameController = TextEditingController(text: imam.name);
    final phoneController = TextEditingController(text: imam.phoneNumber);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Imam Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement edit imam functionality
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, UserModel imam) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Imam'),
        content: Text(
            'Are you sure you want to remove ${imam.name} from the system?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement delete imam functionality
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _viewImamSchedule(UserModel imam) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ImamScheduleScreen(imam: imam),
    //   ),
    // );
  }
}
