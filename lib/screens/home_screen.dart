import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _donations =
      FirebaseFirestore.instance.collection('donations');

  String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 0, 0, 0), // Sky blue background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Greeting Text
              const Text(
                'Hi,',
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // First Card: Total Donated Quantity
              _buildInfoCard(
                title: 'Total Donated',
                stream:
                    _donations.where('userId', isEqualTo: userId).snapshots(),
                valueBuilder: (snapshot) {
                  double totalQuantity = 0;
                  for (var doc in snapshot.data!.docs) {
                    var data = doc.data() as Map<String, dynamic>;
                    totalQuantity +=
                        double.tryParse(data['quantity']?.toString() ?? '0') ??
                            0;
                  }
                  return '$totalQuantity kgs';
                },
              ),

              const SizedBox(height: 20),

              // Second Card: Total Donation Count
              _buildInfoCard(
                title: 'Total Donations',
                stream:
                    _donations.where('userId', isEqualTo: userId).snapshots(),
                valueBuilder: (snapshot) =>
                    snapshot.data!.docs.length.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required Stream<QuerySnapshot> stream,
    required String Function(AsyncSnapshot<QuerySnapshot>) valueBuilder,
  }) {
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: double.infinity, // Cover full width
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade900.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error',
                      style: TextStyle(color: Colors.white));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(color: Colors.white);
                }
                return Text(
                  valueBuilder(snapshot),
                  style: const TextStyle(fontSize: 24.0, color: Colors.white),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
