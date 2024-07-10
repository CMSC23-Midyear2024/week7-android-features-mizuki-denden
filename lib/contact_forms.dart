import 'package:flutter/material.dart';

class ContactForms extends StatefulWidget {
  // stf widget for the slambook page
  const ContactForms({Key? key}) : super(key: key);

  @override
  _ContactFormsState createState() => _ContactFormsState();
}

class _ContactFormsState extends State<ContactForms> {
  // inistializations
  final _formKey = GlobalKey<FormState>(); // forms
  final TextEditingController firstNameController =
      TextEditingController(); // editable text fields
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String labels = '';
  List<String> friends = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your nickname';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: secondNameController,
                  decoration: InputDecoration(
                    labelText: 'Second Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          if (int.tryParse(value) == null) {
                            // [https://api.flutter.dev/flutter/dart-core/num/tryParse.html]
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: secondNameController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        firstNameController.clear();
                        secondNameController.clear();
                        phoneNumberController.clear();
                      });
                    },
                    child: Text("Add Contact"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          String first = "${firstNameController.text}" 
                          String second = "${secondNameController.text}"
                          String number = "${phoneNumberController.text}";
                          String email = "${phoneNumberController.text}";
                          Contact contact = first, second, number, email

                          // friends.add(summaryText); // add the added friend to the friend list
                        });
                        Navigator.pop(
                          context,
                            MaterialPageRoute(
                              builder: (context) => ContactPage(),
                            ),
                          );
                          }
                    },
                    child: Text("Submit"),
                  ),
                  
                ],
              ),
              
            ],
            
          ),
        ),
      ),
      
    );
  }
}
