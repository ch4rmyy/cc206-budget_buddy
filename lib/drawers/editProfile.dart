import 'package:flutter/material.dart';

class ProfileEditorScreen extends StatefulWidget {
  @override
  _ProfileEditorScreenState createState() => _ProfileEditorScreenState();
}

class _ProfileEditorScreenState extends State<ProfileEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _occupationController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _mottoController = TextEditingController();
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Color(0xFF283618),
        foregroundColor: Color(0xFFFEFAE0), // Matches the dark green theme
      ),
      body: Container(
        color: Color(0xFF283618),
        child: Center(
          child: Card(
            color: Color(0xFF283618), // Main card background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 350,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Profile picture
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(''),
                        ),
                        const SizedBox(height: 16),
                        // Name
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter your name'
                              : null,
                        ),
                        SizedBox(height: 20),
                        // Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value == null || !value.contains('@')
                                  ? 'Please enter a valid email'
                                  : null,
                        ),
                        SizedBox(height: 20),
                        // Address
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        // Phone Number
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                controller: TextEditingController(text: "+63"),
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Code',
                                  labelStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _phoneNumberController,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  labelStyle: TextStyle(color: Colors.white70),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white54),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Occupation
                        TextFormField(
                          controller: _occupationController,
                          decoration: InputDecoration(
                            labelText: 'Occupation',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        // Birthdate
                        TextFormField(
                          controller: _birthdateController,
                          decoration: InputDecoration(
                            labelText: 'Birthdate',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.datetime,
                        ),
                        SizedBox(height: 20),
                        // Gender Dropdown
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedGender = newValue!;
                            });
                          },
                          items: <String>['Male', 'Female', 'Other']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                          ),
                          dropdownColor: Colors.lightGreen.shade400,
                        ),
                        SizedBox(height: 20),
                        // Motto
                        TextFormField(
                          controller: _mottoController,
                          decoration: InputDecoration(
                            labelText: 'Motto in Life',
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          maxLines: 3,
                        ),
                        SizedBox(height: 20),
                        // Save Button
                        SizedBox(
                          width: double.infinity, // Full-width button
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Save data logic
                                print('Name: ${_nameController.text}');
                                print('Email: ${_emailController.text}');
                                // ... handle other fields
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFFE5E5C5), // Light button color
                              foregroundColor: Colors.black, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Save Changes'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// /* SCSS RGB */
// $cornsilk: rgba(254, 250, 224, 1) 0xFFFEFAE0;
// $earth-yellow: rgba(221, 161, 94, 1);
// $tigers-eye: rgba(188, 108, 37, 1);
// $dark-moss-green: rgba(96, 108, 56, 1);
// $pakistan-green: rgba(40, 54, 24, 1) 0xFF283618;