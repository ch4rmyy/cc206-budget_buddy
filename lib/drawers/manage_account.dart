import 'package:flutter/material.dart';

class ManageAccountPage extends StatefulWidget {
  const ManageAccountPage({super.key});


  @override
  _ManageAccountPageState createState() => _ManageAccountPageState();
}

  class _ManageAccountPageState extends State<ManageAccountPage>{
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Current Password'),
              ),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
              ),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm New Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                //String currentPassword = _currentPasswordController.text;
                String newPassword = _newPasswordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (newPassword != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Passwords do not match')));
                } else {
                  // Add your actual password update logic here (API call, etc.)
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password changed successfully')));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Change Password'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(96, 108, 56, 1), // Dark green
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFAE0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Manage Account',
          style: TextStyle(
            color: Color(0xFFFEFAE0), 
            fontWeight: FontWeight.bold,
            fontSize: 20     
            ),
        ),
      ),
      body: Container(
        color: const Color(0xFFFEFAE0),
        child: Center(
          child: Card(
            color: const Color(0xFFFEFAE0), 

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
                    const SizedBox(height: 5),
                    _buildClickableOption(
                      context,
                      Icons.lock,
                      'Change Password',
                      () {_changePassword(context);}
                    ),
                    const SizedBox(height: 20),
                    _buildClickableOption(
                      context,
                      Icons.email,
                      'Change Email',
                      () {_changeEmail(context);}
                    ),
                    const SizedBox(height: 20),
                    _buildClickableOption(
                      context,
                      Icons.logout,
                      'Log Out',
                      () {_handleLogout(context);}
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
        backgroundColor: const Color(0xFF283618), // Light button color
        foregroundColor: const Color(0xFFFEFAE0), // Text color
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 20), // Inner padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFFEFAE0)), // Icon on the left
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
        title: Image.asset('assets/images/pig6.png', width: 150,),
        content: const Text(
          'Are you sure you want to log out?', 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
          ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              ),

              TextButton(
                onPressed: () {
                Navigator.pushNamed(context, '/homepage');
                // Perform logout logic here
                showPopUpDialog(context, 'Successfully', 'Loged out');
                },
                child: const Text('Log out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ],
      )
    );
  }


  
    void _changeEmail(BuildContext context) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Image.asset('assets/images/pig6.png', width: 150,),
        content: const Text(
          'Are you sure you want to log out?', 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
          ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              ),

              TextButton(
                onPressed: () {
                Navigator.pushNamed(context, '/homepage');
                // Perform logout logic here
                showPopUpDialog(context, 'Successfully', 'Loged out');
                },
                child: const Text('Log out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
              ),
            ],
          ),
        ],
      )
    );
  }

  void showPopUpDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, //prevent closing when user tap outside
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600),)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(message, style: const TextStyle(fontSize: 20),)],
          ),
      ));
      
    Future.delayed(const Duration(seconds: 2)).then((_){
        if(Navigator.canPop(context)){
          Navigator.of(context).pop();
        }
    });
  }
}
