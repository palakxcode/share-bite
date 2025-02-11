import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SeekScreen extends StatelessWidget {
  final CollectionReference _donations =
      FirebaseFirestore.instance.collection('donations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Seek Donations',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.yellow),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _donations.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading data',
                    style: TextStyle(color: Colors.red, fontSize: 16)));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.yellow));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('No donations available',
                    style: TextStyle(color: Colors.white, fontSize: 16)));
          }

          return ListView(
            padding: const EdgeInsets.all(12),
            children: snapshot.data!.docs.map((document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

              return Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.white, width: 1.5),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow("🏢 Name", "${data['name'] ?? 'N/A'}"),
                      _buildInfoRow(
                          "🍽️ Quantity", "${data['quantity'] ?? 'N/A'} kg"),
                      _buildInfoRow(
                          "🕒 Pick-up Till", data['pickUpTill'] ?? 'N/A'),
                      _buildInfoRow("📍 Address", data['address'] ?? 'N/A'),
                      _buildInfoRow(
                          "❄️ Storage", data['storageCondition'] ?? 'N/A'),
                      _buildInfoRow(
                          "🟢 Freshness", data['freshnessLevel'] ?? 'N/A'),
                      _buildInfoRow(
                          "🥦 Dietary Info", data['dietaryInfo'] ?? 'N/A'),
                      _buildInfoRow(
                          "⚠️ Allergy Info", data['allergyInfo'] ?? 'N/A'),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
