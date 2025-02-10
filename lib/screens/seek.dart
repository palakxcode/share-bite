import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeekScreen extends StatelessWidget {
  final CollectionReference _donations =
      FirebaseFirestore.instance.collection('donations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seek Donations'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _donations.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No donations available'));
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Quantity: ${data['quantity']} kg'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pick-up Till: ${data['pickUpTill']}'),
                      Text('Address: ${data['address']}'),
                      Text('Storage Condition: ${data['storageCondition']}'),
                      Text('Freshness Level: ${data['freshnessLevel']}'),
                      Text('Dietary Info: ${data['dietaryInfo']}'),
                      Text('Allergy Info: ${data['allergyInfo']}'),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
