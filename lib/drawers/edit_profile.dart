
import 'package:flutter/material.dart';

class ProfileEditorScreen extends StatefulWidget {
  const ProfileEditorScreen({super.key});

  @override
  ProfileEditorScreenState createState() => ProfileEditorScreenState();
}

class ProfileEditorScreenState extends State<ProfileEditorScreen> {
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
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF606C38),
        foregroundColor: const Color(0xFFFEFAE0),
        toolbarHeight: 70,
        leading: 
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFEFAE0)),
            onPressed: (){
              Navigator.pop(context);
            } 

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
                width: 350,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Profile picture
                        Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/pig8.png')),
                              
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Name
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF283618)),
                            ),
                          ),
                          style: const TextStyle(color: Color(0xFF283618)),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter your name'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        // Email
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF283618)),
                            ),
                          ),
                          style: const TextStyle(color: Color(0xFF283618)),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value == null || !value.contains('@')
                                  ? 'Please enter a valid email'
                                  : null,
                        ),
                        const SizedBox(height: 20),
                        // Address
                        TextFormField(
                          controller: _addressController,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                            labelStyle: TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF283618)),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        // Phone Number
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                controller: TextEditingController(text: "+63"),
                                enabled: false,
                                decoration: const InputDecoration(
                                  labelText: 'Code',
                                  labelStyle: TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(color: Color(0xFF283618)),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _phoneNumberController,
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  labelStyle: TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF283618)),
                                  ),
                                ),
                                style: const TextStyle(color: Color(0xFF283618)),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Occupation
                        TextFormField(
                          controller: _occupationController,
                          decoration: const InputDecoration(
                            labelText: 'Occupation',
                            labelStyle: TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF283618)),
                            ),
                          ),
                          style: const TextStyle(color: Color(0xFF283618)),
                        ),
                        const SizedBox(height: 20),
                        // Birthdate
                        TextFormField(
                          controller: _birthdateController,
                          decoration: const InputDecoration(
                            labelText: 'Birthdate',
                            labelStyle: TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF283618)),
                            ),
                          ),
                          style: const TextStyle(color: Color(0xFF283618)),
                          keyboardType: TextInputType.datetime,
                        ),
                        const SizedBox(height: 20),
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
                                  style: const TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600)),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            labelStyle: TextStyle(color: Color.fromARGB(255, 85, 106, 61), fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF283618)),
                            ),
                          ),
                          dropdownColor: const Color(0xFF606C38),
                        ),
                        const SizedBox(height: 20),
                        // Motto
                        TextFormField(
                          controller: _mottoController,
                          decoration: const InputDecoration(
                            labelText: 'Motto in Life',
                            labelStyle: TextStyle(color: Color(0xFF283618), fontWeight: FontWeight.w600),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF283618)),
                            ),
                          ),
                          style: const TextStyle(color: Color(0xFF283618)),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),
                        // Save Button
                        SizedBox(
                          width: double.infinity, 
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print('Name: ${_nameController.text}');
                                print('Email: ${_emailController.text}');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(227, 135, 55, 1), 
                              foregroundColor: const Color(0xFFFEFAE0), 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.w700),),
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
