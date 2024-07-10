import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class ContactForms extends StatefulWidget {
  const ContactForms({Key? key}) : super(key: key);

  @override
  _ContactFormsState createState() => _ContactFormsState();
}

class _ContactFormsState extends State<ContactForms> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();                    // TextEditingControllers for textfields
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? imageFile;                                                                              // variable for image file
  Permission permission = Permission.camera;                                                    // permission for camera
  PermissionStatus permissionStatus = PermissionStatus.denied;

  @override
  void initState() {                                                                            // copied from the demo 
    super.initState();
    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status = await permission.status;
    setState(() => permissionStatus = status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Contact")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(                                                                            // form for the textfields data to be saved in the contacts 
          key: _formKey,                        
          child: ListView(                                                                      // child of form is in ListView               
            children: [
              GestureDetector(                                                                  // https://api.flutter.dev/flutter/widgets/GestureDetector-class.html
                onTap: () async {                                                               // since a button was not used for the exercise instead a changing icon depending on the picked image
                    if (permissionStatus == PermissionStatus.granted) {                          
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      setState(() {
                        imageFile = image == null ? null : File(image.path);
                      });
                    } else {
                      requestPermission();
                    }
                  },
                child: CircleAvatar(                                                            // https://blog.logrocket.com/clipping-circles-flutter/
                  radius: 40,
                  backgroundImage: imageFile != null ? FileImage(imageFile!) : null,            // if the user took an image it will be it will be displayed as the background image
                  child: imageFile == null ? Icon(Icons.add_a_photo) : null,                    // if the user didnt uplaod an image, it will just be an icon  
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),                                      
                child: TextFormField(                                                            // textfield for the first name 
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),                   
                  validator: (value) {                                                           // validator to make it required
                    if (value == null || value.isEmpty) { 
                      return 'Please enter a first name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(                                                             // textfield for the second name 
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(                                                             // textfield for the phone number
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {                                                           // validator to make it required
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';                                      // if nothing is put
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid phone number';                                // if the input is not a number
                    }
                    return null;                                                                 
                  },
                ),
              ),
              Padding(                                                          
                padding: EdgeInsets.all(20),
                child: TextFormField(                                                             // textfield for the email
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {                                   // after validation 
                        addContact();                                                            // it will perform addContact method
                        Navigator.pop(context);                                                  // then pop the current screen
                      }
                    },
                    child: Text("Add Contact"),                                                                                               
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  void addContact() async {                                                       // pub.dev                                                 
    final contact = Contact()
      ..name.first = firstNameController.text
      ..name.last = lastNameController.text
      ..emails = [Email(emailController.text)]
      ..phones = [Phone(phoneNumberController.text)];
    await contact.insert();
  }

    Future<void> requestPermission() async {                                        // copied from demo
    final status = await permission.request();

    setState(() {
      print(status);
      permissionStatus = status;
      print(permissionStatus);
    });
  }
}
