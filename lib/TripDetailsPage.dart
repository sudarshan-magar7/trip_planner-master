import 'package:flutter/material.dart';

class TripDetailsPage extends StatelessWidget {
  const TripDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Trip Data'),
        backgroundColor: const Color(0xFF6878E7),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Header(title: 'Trip Overview'),
            const TripDetailsCard(
              title: 'Bali, Indonesia',
              description:
                  'A beautiful trip to Bali with beach activities and cultural experiences.',
              startDate: '2024-06-01',
              endDate: '2024-06-07',
            ),
            const SizedBox(height: 20),
            const Header(title: 'Itinerary'),
            const ItineraryList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;

  const Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6878E7),
      ),
    );
  }
}

class TripDetailsCard extends StatelessWidget {
  final String title;
  final String description;
  final String startDate;
  final String endDate;

  const TripDetailsCard({
    super.key,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dates: $startDate - $endDate',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItineraryList extends StatelessWidget {
  const ItineraryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text('$index'),
              ),
              title: Text('Activity ${index + 1}'),
              subtitle: Text('Description for activity ${index + 1}'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class TripDetailsPage extends StatelessWidget {
//   // Temporary sample data
//   final String destination = "Paris, France";
//   final DateTime startDate = DateTime(2025, 5, 10);
//   final DateTime endDate = DateTime(2025, 5, 20);
//   final int numberOfTravelers = 2;
//   final String transportationMode = "Flight";
//   final double budget = 1500.0;
//   final String tripDescription =
//       "A week-long trip to explore the beautiful city of Paris, visiting famous landmarks and enjoying local cuisine.";
//
//   TripDetailsPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Trip Destination with an Image
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       'https://via.placeholder.com/100.png?text=Destination',
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Text(
//                       destination,
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//
//               // Dates with Icons
//               _buildInfoRow(
//                 icon: Icons.date_range,
//                 title: 'Start Date',
//                 value: startDate.toLocal().toString().split(' ')[0],
//               ),
//               SizedBox(height: 8),
//               _buildInfoRow(
//                 icon: Icons.date_range,
//                 title: 'End Date',
//                 value: '${endDate.toLocal().toString().split(' ')[0]}',
//               ),
//               SizedBox(height: 16),
//
//               // Number of Travelers with Icon
//               _buildInfoRow(
//                 icon: Icons.group,
//                 title: 'Number of Travelers',
//                 value: numberOfTravelers.toString(),
//               ),
//               SizedBox(height: 16),
//
//               // Transportation Mode with Icon
//               _buildInfoRow(
//                 icon: Icons.airplanemode_active,
//                 title: 'Transportation Mode',
//                 value: transportationMode,
//               ),
//               SizedBox(height: 16),
//
//               // Budget with Icon
//               _buildInfoRow(
//                 icon: Icons.monetization_on,
//                 title: 'Budget',
//                 value: '\$${budget.toStringAsFixed(2)}',
//               ),
//               SizedBox(height: 16),
//
//               // Trip Description with Header
//               Text(
//                 'Trip Description:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 tripDescription,
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 24),
//
//               // Close Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent,
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Close',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Helper method to build info rows
//   Widget _buildInfoRow({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Icon(icon, color: Colors.redAccent),
//         SizedBox(width: 12),
//         Text(
//           '$title: ',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ],
//     );
//   }
// }
