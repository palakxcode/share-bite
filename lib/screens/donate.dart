import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pickUpController = TextEditingController();
  String _storageCondition = 'Room Temperature';
  String _freshnessLevel = 'Fresh';
  String _dietaryInfo = 'Veg';
  String _allergyInfo = 'None';

  List<String> storageConditions = [
    'Room Temperature',
    'Refrigerated',
    'Frozen'
  ];
  List<String> freshnessLevels = ['Fresh', 'Good', 'Okay', 'Not Fresh'];
  List<String> dietaryInfos = ['Veg', 'Non-Veg', 'Contains Egg'];
  List<String> allergyInfos = ['None', 'Milk', 'Nuts', 'Wheat/maida'];

  final CollectionReference _donations =
      FirebaseFirestore.instance.collection('donations');

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        await _donations.add({
          'userId': userId,
          'name': _nameController.text,
          'quantity': _quantityController.text,
          'pickUpTill': _pickUpController.text,
          'address': _addressController.text,
          'storageCondition': _storageCondition,
          'freshnessLevel': _freshnessLevel,
          'dietaryInfo': _dietaryInfo,
          'allergyInfo': _allergyInfo,
          'timestamp': FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Donation submitted successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit donation: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Text(
                'Donation Details',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              buildTextField(
                  'Enter reg. name', _nameController, TextInputType.text),
              buildTextField('Quantity (in kgs)', _quantityController,
                  TextInputType.number),
              buildTextField(
                  'Pick-up Till', _pickUpController, TextInputType.datetime),
              buildTextField('Address', _addressController, TextInputType.text),
              buildDropdown(
                  'Storage Condition', storageConditions, _storageCondition,
                  (value) {
                setState(() => _storageCondition = value!);
              }),
              buildDropdown('Freshness Level', freshnessLevels, _freshnessLevel,
                  (value) {
                setState(() => _freshnessLevel = value!);
              }),
              buildDropdown('Dietary Info', dietaryInfos, _dietaryInfo,
                  (value) {
                setState(() => _dietaryInfo = value!);
              }),
              buildDropdown('Allergy Info', allergyInfos, _allergyInfo,
                  (value) {
                setState(() => _allergyInfo = value!);
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _submitForm,
                child: const Text('Submit Donation',
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        keyboardType: inputType,
        style: const TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String selectedItem,
      void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: selectedItem,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        dropdownColor: Colors.black,
        style: const TextStyle(color: Colors.white),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: const TextStyle(color: Colors.white)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
