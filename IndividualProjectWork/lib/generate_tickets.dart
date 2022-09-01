import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_project/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'drawer.dart';
import 'dart:io';

class GenerateTickets extends StatefulWidget {
  const GenerateTickets({Key? key}) : super(key: key);

  @override
  State<GenerateTickets> createState() => _GenerateTicketsState();
}

class _GenerateTicketsState extends State<GenerateTickets> {
  // final formKey = GlobalKey<FormState>(); //for form validation
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final contactEmail = TextEditingController();
  final address = TextEditingController();
  final documentType = TextEditingController();
  final documentNumber = TextEditingController();
  final placeFound = TextEditingController();
  final district = TextEditingController();
  final photo = TextEditingController();
  List<String> items = ['Citizenship ID', 'Passport', 'License', 'Others'];
  String? selectedItem = '';
  File? image;
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  Future clickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });
  }

  // Future addDetails(
  //     String fullName,
  //     int phoneNumber,
  //     String contactEmail,
  //     String address,
  //     String documentType,
  //     String documentNumber,
  //     String placeFound,
  //     String district) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'fullName': fullName,
  //     'phoneNumber': phoneNumber,
  //     'contactEmail': contactEmail,
  //     'address': address,
  //     'documentType': documentType,
  //     'documentNumber': documentNumber,
  //     'placeFound': placeFound,
  //     'district': district
  //   });
  // }

  Future addDetails(UserDetail user) async {
    final collection = FirebaseFirestore.instance.collection('users').doc();
    user.id = collection.id;
    final json = user.toJson();
    await collection.set(json);
  }

  // clear text fields
  void clearTextField() {
    fullName.clear();
    phoneNumber.clear();
    contactEmail.clear();
    address.clear();
    documentType.clear();
    documentNumber.clear();
    placeFound.clear();
    district.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate a ticket'),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            // key: formKey,
            child: Column(
              children: [
                Text(
                  'User information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 14),
                TextFormField(
                  controller: fullName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), //for height
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person, color: Colors.deepPurple),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  // validator: (value) {},
                ),
                SizedBox(height: 14),
                TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), //for height
                    hintText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone, color: Colors.deepPurple),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  // validator: (value) {},
                ),
                SizedBox(height: 14),
                TextFormField(
                  controller: contactEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), //for height
                    hintText: 'Valid Email',
                    prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  // validator: (value) {},
                ),
                SizedBox(height: 14),
                TextFormField(
                  controller: address,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), //for height
                    hintText: 'Address',
                    prefixIcon:
                        Icon(Icons.location_city, color: Colors.deepPurple),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  // validator: (value) {},
                ),
                SizedBox(height: 14),
                Text(
                  'Document Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 14),
                DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 7), //for height
                      hintText: 'Select document type',
                      prefixIcon:
                          Icon(Icons.square_rounded, color: Colors.deepPurple),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    icon: Icon(Icons.arrow_drop_down_circle,
                        color: Colors.deepPurple),
                    items: items
                        .map((currentItem) => DropdownMenuItem<String>(
                            value: currentItem,
                            child: Text(
                              currentItem,
                            )))
                        .toList(),
                    onChanged: (currentItem) => setState(() {
                          selectedItem = currentItem;
                        })),
                SizedBox(height: 14),
                TextFormField(
                  controller: documentNumber,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), //for height
                    hintText: 'Document Number',
                    // labelStyle: TextStyle(),
                    prefixIcon:
                        Icon(Icons.numbers_outlined, color: Colors.deepPurple),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  // validator: (value) {},
                ),
                SizedBox(height: 14),
                TextFormField(
                  controller: placeFound,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), //for height
                    hintText: 'Place Found',
                    // labelStyle: TextStyle(),
                    prefixIcon: Icon(Icons.place, color: Colors.deepPurple),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  // validator: (value) {},
                ),
                SizedBox(height: 14),
                TextFormField(
                  controller: district,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15), //for height
                    hintText: 'District',
                    // labelStyle: TextStyle(),
                    prefixIcon: Icon(Icons.house, color: Colors.deepPurple),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0, color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  // validator: (value) {},
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: Text(
                        'Add Photo',
                      ),
                      label: Icon(Icons.image),
                      onPressed: () {
                        pickImage();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[200],
                        onPrimary: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton.icon(
                      icon: Text(
                        'Take Photo',
                      ),
                      label: Icon(Icons.camera_alt),
                      onPressed: () {
                        clickImage();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[200],
                        onPrimary: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton.icon(
                  icon: Text(
                    'Generate',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  label: Icon(Icons.generating_tokens),
                  onPressed: () {
                    final user = UserDetail(
                      id: '',
                      fullName: fullName.text,
                      phoneNumber: int.parse(phoneNumber.text),
                      contactEmail: contactEmail.text,
                      address: address.text,
                      documentType: documentType.text,
                      documentNumber: documentNumber.text,
                      placeFound: placeFound.text,
                      district: district.text,
                    );
                    addDetails(user);
                    clearTextField();
                    // print(user.id);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(245, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
