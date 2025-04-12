import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InquiryPage extends StatelessWidget {
  const InquiryPage({super.key});

  // Function to fetch inquiries from the backend
  Future<List<Map<String, dynamic>>> fetchInquiries() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/tripInquiries?userId=4'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      // Assuming the backend response is in the following format:
      // {
      //   "success": true,
      //   "msg": "Trip inquiries retrieved successfully.",
      //   "data": [ {inquiry1}, {inquiry2}, ... ]
      // }
      List<dynamic> inquiriesList = body['data'];
      return inquiriesList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load inquiries');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('Trip Inquiries', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6878E7),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchInquiries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final inquiries = snapshot.data ?? [];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  for (var inquiry in inquiries) InquiryCard(inquiry: inquiry),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFFB5BEFF),
    );
  }
}

class InquiryCard extends StatelessWidget {
  final Map<String, dynamic> inquiry;

  const InquiryCard({super.key, required this.inquiry});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inquiry['destination'] ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              inquiry['description'] ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${inquiry['status'] ?? ''}',
              style: TextStyle(
                fontSize: 16,
                color: inquiry['status'] == 'APPROVED'
                    ? Colors.green
                    : inquiry['status'] == 'REJECTED'
                    ? Colors.red
                    : Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Plan Approval: ${inquiry['approval'] == true ? 'Approved' : 'Not Approved'}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: inquiry['approval'] == true ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
