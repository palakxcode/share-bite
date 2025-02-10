import 'package:flutter/material.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({super.key});

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity (in kgs)'),
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
                decoration: InputDecoration(labelText: 'Pick-up Till'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pick-up time';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _storageCondition,
                decoration: InputDecoration(labelText: 'Storage Condition'),
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
                decoration: InputDecoration(labelText: 'Freshness Level'),
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
                decoration: InputDecoration(labelText: 'Dietary Info'),
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
                decoration: InputDecoration(labelText: 'Allergy Info'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
