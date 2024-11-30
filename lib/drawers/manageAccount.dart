import 'package:flutter/material.dart';

class ManageAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B3A2C), // Dark green
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back action
          },
        ),
        title: const Text(
          'Manage Account',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: const Color(0xFF3C4F3D),
        child: Center(
          child: Card(
            color: const Color(0xFF3C4F3D), // Matches the dark green theme

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 350, // Match width of ProfileEditorScreen card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(color: Colors.white54),
                    const SizedBox(height: 20),
                    _buildClickableOption(
                      context,
                      Icons.lock,
                      'Change Password',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordPage()),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildClickableOption(
                      context,
                      Icons.email,
                      'Change Email',
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeEmailPage()),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildClickableOption(
                      context,
                      Icons.logout,
                      'Log Out',
                      () => _handleLogout(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClickableOption(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE5E5C5), // Light button color
        foregroundColor: Colors.black, // Text color
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 20), // Inner padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black), // Icon on the left
          const SizedBox(width: 10),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft, // Align text to the left
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10), // Add extra padding to the label
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform logout logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully!')),
              );
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: const Color(0xFF2B3A2C),
      ),
      body: const Center(
        child: Text(
          'Change Password Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class ChangeEmailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Email'),
        backgroundColor: const Color(0xFF2B3A2C),
      ),
      body: const Center(
        child: Text(
          'Change Email Screen',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
