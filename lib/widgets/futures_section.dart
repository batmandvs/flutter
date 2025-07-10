import 'package:flutter/material.dart';

class FuturesSection extends StatelessWidget {
  const FuturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.piano,
        'title': 'Premium Craftsmanship',
        'desc':
            'Each piano is crafted with precision and passion for a timeless sound.',
      },
      {
        'icon': Icons.spatial_audio,
        'title': 'Immersive Acoustic Technology',
        'desc':
            'Experience next-level sound with our advanced acoustic engineering.',
      },
      {
        'icon': Icons.school,
        'title': 'Free Online Lessons',
        'desc': 'Get started with free lessons from expert pianists, anytime.',
      },
      {
        'icon': Icons.star_rate,
        'title': 'Trusted by Professionals',
        'desc':
            'Top musicians and studios around the world choose our pianos.',
      },
    ];

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Our Features",
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Why musicians choose Piano Harmony?",
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            "Experience the Art of Music",
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.w500,
              color: Colors.indigo[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          isMobile
              ? Column(
                  children:
                      features.map((feature) => _buildFeatureCard(feature)).toList(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: features
                      .map((feature) => Expanded(
                              child: _buildFeatureCard(feature)))
                      .toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[100]!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(feature['icon'], size: 48, color: Colors.indigo),
          const SizedBox(height: 16),
          Text(
            feature['title'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            feature['desc'],
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
