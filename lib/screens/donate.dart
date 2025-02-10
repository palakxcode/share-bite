import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
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
        await _donations.add({
          'quantity': _quantityController.text,
          'pickUpTill': _pickUpController.text,
          'address': _addressController,
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
      appBar: AppBar(
        title: const Text('Donate Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _quantityController,
                decoration:
                    const InputDecoration(labelText: 'Quantity (in kgs)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pickUpController,
                decoration: const InputDecoration(labelText: 'Pick-up Till'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pick-up time';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pick-up address';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _storageCondition,
                decoration:
                    const InputDecoration(labelText: 'Storage Condition'),
                items: storageConditions.map((condition) {
                  return DropdownMenuItem<String>(
                    value: condition,
                    child: Text(condition),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _storageCondition = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _freshnessLevel,
                decoration: const InputDecoration(labelText: 'Freshness Level'),
                items: freshnessLevels.map((level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _freshnessLevel = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _dietaryInfo,
                decoration: const InputDecoration(labelText: 'Dietary Info'),
                items: dietaryInfos.map((info) {
                  return DropdownMenuItem<String>(
                    value: info,
                    child: Text(info),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _dietaryInfo = value!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _allergyInfo,
                decoration: const InputDecoration(labelText: 'Allergy Info'),
                items: allergyInfos.map((level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _allergyInfo = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
