import 'package:flutter/material.dart';
import 'package:trip_planner/InquiryPage.dart';
import 'package:trip_planner/TripDetailsPage.dart';

import 'AnalyzePlanPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Trip Planner',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor:
              const Color(0xFF6878E7), // Using #6878E7 for AppBar background
          bottom: const TabBar(
            indicatorColor:
                Color(0xFFD1DEFE), // #D1DEFE for the active tab indicator
            labelColor: Color(0xFFFFFFFF), // White text for active tabs
            unselectedLabelColor:
                Color(0xFFB5BEFF), // #B5BEFF for inactive tabs
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.flight_takeoff), text: 'My Trips'),
              Tab(icon: Icon(Icons.hourglass_empty), text: 'Wait List'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeTab(),
            MyTripsTab(),
            WaitlistTab(),
          ],
        ),
        backgroundColor:
            const Color(0xFFD1DEFE), // Light background for the page
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Example trip data with number of members
    final List<Map<String, dynamic>> trips = [
      {
        'title': 'Beach Paradise',
        'description': 'Relax on the sunny beaches of Bali.',
        'icon': Icons.beach_access,
        'members': 4,
      },
      {
        'title': 'Mountain Adventure',
        'description': 'Explore the majestic Rockies.',
        'icon': Icons.landscape,
        'members': 2,
      },
      {
        'title': 'City Escapade',
        'description': 'Discover the wonders of New York City.',
        'icon': Icons.location_city,
        'members': 5,
      },
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB5BEFF), Color(0xFF6878E7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Welcome to Trip Planner!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/planTrip');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF6878E7),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                  ),
                  icon: Icon(Icons.add_circle_outline),
                  label: Text(
                    'Plan Your Trip',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Recommended Trips',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFD1DEFE),
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(12)),
                        ),
                        child: Icon(
                          trip['icon'] as IconData,
                          size: 50,
                          color: Color(0xFF6878E7),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trip['title']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                trip['description']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Members: ${trip['members']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TripDetailsPage()),
                                    );
                                  },
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(color: Color(0xFF6878E7)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyTripsTab extends StatefulWidget {
  const MyTripsTab({super.key});

  @override
  State<MyTripsTab> createState() => _MyTripsTabState();
}

class _MyTripsTabState extends State<MyTripsTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> myTrips = [
      {
        'destination': 'Bali, Indonesia',
        'date': '2025-06-15 to 2025-06-20',
        'status': 'Upcoming',
        'image':
            'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3fDB8MHwxfGFsbHwxfHx8fHx8fHwxNjc0NjQ4MTg3&ixlib=rb-1.2.1&q=80&w=400',
      },
      {
        'destination': 'Tokyo, Japan',
        'date': '2025-03-01 to 2025-03-10',
        'status': 'Completed',
        'image':
            'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3fDB8MHwxfGFsbHwzfHx8fHx8fHwxNjc0NjQ4MTg3&ixlib=rb-1.2.1&q=80&w=400',
      },
      {
        'destination': 'Paris, France',
        'date': '2025-04-10 to 2025-04-18',
        'status': 'Cancelled',
        'image':
            'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxMTc3fDB8MHwxfGFsbHwzfHx8fHx8fHwxNjc0NjQ4MTg3&ixlib=rb-1.2.1&q=80&w=400',
      },
    ];

    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4A56E2),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF4A56E2),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              buildTripList(myTrips), // All trips
              buildTripList(myTrips
                  .where((trip) => trip['status'] == 'Upcoming')
                  .toList()), // Upcoming trips
              buildTripList(myTrips
                  .where((trip) => trip['status'] == 'Completed')
                  .toList()), // Completed trips
              buildTripList(myTrips
                  .where((trip) => trip['status'] == 'Cancelled')
                  .toList()), // Cancelled trips
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTripList(List<Map<String, dynamic>> trips) {
    if (trips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.flight_takeoff, size: 100, color: Color(0xFF4A56E2)),
            SizedBox(height: 16),
            Text(
              'No trips found!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A56E2),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: trips.map((trip) => TripCard(trip: trip)).toList(),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final Map<String, dynamic> trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.network(
              trip['image'],
              height: 180,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error, size: 100));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip['destination'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  trip['date'],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Status: ${trip['status']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: trip['status'] == 'Upcoming'
                        ? Colors.green
                        : (trip['status'] == 'Cancelled'
                            ? Colors.red
                            : Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WaitlistTab extends StatelessWidget {
  const WaitlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Plan Your Trips',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildOptionCard(
            context,
            title: 'Inquiry',
            description:
                'Submit inquiries about destinations or travel options.',
            icon: Icons.search,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InquiryPage()),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildOptionCard(
            context,
            title: 'Analyze Trip',
            description:
                'Get insights and recommendations for your selected destinations.',
            icon: Icons.analytics,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnalyzePlanPage()),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildOptionCard(
            context,
            title: 'Create Plan',
            description:
                'Organize your trips by creating detailed travel plans.',
            icon: Icons.edit_calendar,
            onTap: () {
              // Navigate to the Create Plan page or perform related actions
            },
          ),
        ],
      ),
    );
  }

  // Helper widget to build each option card
  Widget _buildOptionCard(BuildContext context,
      {required String title,
      required String description,
      required IconData icon,
      required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blueAccent),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
