import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  final bool isMobile;

  const ContactSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "If you have any questions or need assistance, please reach out to us.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 30),
        _buildContactCard(Icons.phone, "Phone", "+62 812-3456-7890"),
        const SizedBox(height: 16),
        _buildContactCard(Icons.email, "Email", "info@pianoworld.com"),
        const SizedBox(height: 16),
        _buildContactCard(Icons.location_on, "Address", "Jl. Musik No. 1, Jakarta"),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      children: [
        const Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "If you have any questions or need assistance, please reach out to us.",
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: _buildContactCard(Icons.phone, "Phone", "+62 812-3456-7890")),
            const SizedBox(width: 20),
            Expanded(child: _buildContactCard(Icons.email, "Email", "info@pianoworld.com")),
            const SizedBox(width: 20),
            Expanded(child: _buildContactCard(Icons.location_on, "Address", "Jl. Musik No. 1, Jakarta")),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.blueAccent),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
