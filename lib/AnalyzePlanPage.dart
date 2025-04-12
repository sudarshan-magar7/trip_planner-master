import 'package:flutter/material.dart';

class AnalyzePlanPage extends StatefulWidget {
  const AnalyzePlanPage({super.key});

  @override
  _AnalyzePlanPageState createState() => _AnalyzePlanPageState();
}

class _AnalyzePlanPageState extends State<AnalyzePlanPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip Plan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF6878E7),
        elevation: 5,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildTabBar(),
          const SizedBox(height: 16),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (widget, animation) {
                return FadeTransition(opacity: animation, child: widget);
              },
              child: DayTimeline(
                key: ValueKey(selectedIndex),
                dayNumber: selectedIndex + 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: selectedIndex == index
                    ? const LinearGradient(
                        colors: [Color(0xFF6878E7), Color(0xFF8A9EFE)])
                    : null,
                color: selectedIndex == index
                    ? null
                    : Colors.grey.shade300, // Default color for unselected
                boxShadow: selectedIndex == index
                    ? [
                        BoxShadow(
                          color: const Color(0xFF6878E7).withOpacity(0.5),
                          blurRadius: 6,
                        )
                      ]
                    : [],
              ),
              child: Text(
                'Day ${index + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? Colors.white : Colors.black54,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class DayTimeline extends StatelessWidget {
  final int dayNumber;

  const DayTimeline({super.key, required this.dayNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFB5BEFF),
            dayNumber == 1
                ? const Color(0xFFD1DEFE)
                : dayNumber == 2
                    ? const Color(0xFFCAF7E3)
                    : const Color(0xFFFAD6A5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            DayPlanEvent(
              time: '5:20 AM',
              description: 'Trekking\nIdi-Araba',
              icon: Icons.hiking,
            ),
            DayPlanEvent(
              time: '6:40 AM',
              description: 'Breakfast\nat the Hotel',
              icon: Icons.restaurant,
            ),
            DayPlanEvent(
              time: '8:35 AM',
              description: 'Karaoke\nat the Club',
              icon: Icons.music_note,
            ),
            DayPlanEvent(
              time: '11:45 AM',
              description: 'Taking some rest\nat the Hotel',
              icon: Icons.hotel,
            ),
          ],
        ),
      ),
    );
  }
}

class DayPlanEvent extends StatelessWidget {
  final String time;
  final String description;
  final IconData icon;

  const DayPlanEvent({
    super.key,
    required this.time,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6878E7), Color(0xFF8A9EFE)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: AnimatedIconButton(icon: icon),
              ),
              Container(
                height: 50,
                width: 2,
                color: Colors.grey.shade400,
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Card(
              elevation: 8,
              shadowColor: Colors.black26,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedIconButton extends StatefulWidget {
  final IconData icon;

  const AnimatedIconButton({super.key, required this.icon});

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.2,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    );
  }

  void _onTap() {
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Icon(
          widget.icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
