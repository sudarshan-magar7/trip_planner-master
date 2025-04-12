import 'package:flutter/material.dart';
import 'UploadVideoPage.dart';

class PlanTripPage extends StatelessWidget {
  const PlanTripPage({super.key});

  static const Color primaryColor = Color(0xFF6878E7);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> options = [
      {
        'title': 'Video',
        'description': 'Explore destinations through curated travel vlogs.',
        'smallDescription': 'Visualize your next adventure!',
        'icon': Icons.videocam,
        'gradient': [Color(0xFF2193B0), Color(0xFF6DD5ED)],
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadVideoPage()),
          );
        },
      },
      {
        'title': 'Photo',
        'description': 'Browse breathtaking travel photos.',
        'smallDescription': 'Capture the beauty around!',
        'icon': Icons.photo,
        'gradient': [Color(0xFFFF512F), Color(0xFFDD2476)],
        'onTap': () {
          print('Photo Tapped');
        },
      },
      {
        'title': 'Link',
        'description': 'Find guides, reviews, and booking resources.',
        'smallDescription': 'Plan smarter, travel better!',
        'icon': Icons.link,
        'gradient': [Color(0xFF56CCF2), Color(0xFF2F80ED)],
        'onTap': () {
          print('Link Tapped');
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan Your Trip',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return _OptionCard(
              title: option['title'],
              description: option['description'],
              smallDescription: option['smallDescription'],
              icon: option['icon'],
              gradient: option['gradient'],
              onTap: option['onTap'],
            );
          },
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String title;
  final String description;
  final String smallDescription;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _OptionCard({
    required this.title,
    required this.description,
    required this.smallDescription,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20, // Increased font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.white60),
                    const SizedBox(width: 4),
                    Text(
                      smallDescription,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white60,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
