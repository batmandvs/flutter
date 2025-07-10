import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final ScrollController scrollController;
  final GlobalKey featuresKey; // ✅ Tambahkan key

  const NavBar({
    super.key,
    required this.scrollController,
    required this.featuresKey,
  });

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        children: [
          // Logo dan judul
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                ),
                child: const Center(
                  child: Text("PW", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 10),
              const Text("Piano World", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          if (!isSmallScreen) ...[
            NavItem(title: "Home", onTap: () => _scrollTo(0)),
            NavItem(title: "Products", onTap: () => _scrollTo(600)), // Optional: adjust
            NavItem(title: "Features", onTap: _scrollToFeatures),
            NavItem(title: "Contact", onTap: () => _scrollTo(3000)), // Optional: adjust
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => _navigate(context, '/login'),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.purple, Colors.lightBlueAccent]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text("Login", style: TextStyle(color: Colors.white)),
              ),
            ),
          ] else
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                switch (value) {
                  case 'home':
                    _scrollTo(0);
                    break;
                  case 'products':
                    _scrollTo(600); // Optional
                    break;
                  case 'features':
                    _scrollToFeatures();
                    break;
                  case 'contact':
                    _scrollTo(3000); // Optional
                    break;
                  case 'login':
                    _navigate(context, '/login');
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'home', child: Text('Home')),
                const PopupMenuItem(value: 'products', child: Text('Products')),
                const PopupMenuItem(value: 'features', child: Text('Features')),
                const PopupMenuItem(value: 'contact', child: Text('Contact')),
                const PopupMenuItem(value: 'login', child: Text('Login')),
              ],
            ),
        ],
      ),
    );
  }

  void _scrollTo(double offset) {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToFeatures() {
    final context = featuresKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigate(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const NavItem({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
