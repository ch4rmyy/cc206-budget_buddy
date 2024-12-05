import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // Sample user data, these could be fetched from a database or API
  String name = 'John Doe';
  String email = 'johndoe@example.com';
  String phoneNumber = '+63 9123456789';
  String gender = 'Male';
  String address = '123 Street, City, Country';
  String occupation = 'Software Developer';
  String birthdate = 'January 1, 1990';
  String motto = 'Keep it simple';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile picture (placeholder)
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/pig8.png'), // Placeholder image
              ),
            ),
            SizedBox(height: 20),
            // Name
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Email
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Phone Number
            Text('Phone: $phoneNumber', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Gender
            Text('Gender: $gender', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Address
            Text('Address: $address', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Occupation
            Text('Occupation: $occupation', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Birthdate
            Text('Birthdate: $birthdate', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            // Motto
            Text('Motto: $motto', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}