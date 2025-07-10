import 'package:flutter/material.dart';
import 'utils/responsiveLayout.dart';
import 'widgets/navbar.dart';
import 'widgets/search.dart';
import 'widgets/contact_section.dart';
import 'widgets/futures_section.dart';

final List<Map<String, String>> productList = [
  {
    'name': 'Grand Piano Steinway',
    'description': 'A legendary grand piano known for its rich tones.',
    'image': 'assets/steinwey.jpeg',
  },
  {
    'name': 'Kawai Digital',
    'description': 'Modern digital piano with authentic feel.',
    'image': 'assets/kawai.jpeg',
  },
  {
    'name': 'Upright Classic',
    'description': 'Perfect for home practice and small spaces.',
    'image': 'assets/upright.jpeg',
  },
  {
    'name': 'Digital Piano Roland RP107 Original',
    'description': 'Piano SoundSuperNATURAL PianoMax. Polyphony256 voicesTonesTotal Available Tones: 324',
    'image': 'assets/roland.jpeg',
  },
  {
    'name': 'Kawai Stage',
    'description': 'Portable stage piano with powerful sound.',
    'image': 'assets/pollman.jpeg',
  },
  {
    'name': 'Piano Yamaha U1',
    'description': 'Compact yet powerful upright piano.',
    'image': 'assets/piano_yamaha.jpg',
  },
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Landing Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _featuresKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            NavBar(
              scrollController: _scrollController,
              featuresKey: _featuresKey,
            ),
            Body(featuresKey: _featuresKey),
            ResponsiveLayout(
              largeScreen: const ContactSection(isMobile: false),
              smallScreen: const ContactSection(isMobile: true),
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final GlobalKey featuresKey;
  const Body({super.key, required this.featuresKey});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeChild(featuresKey: featuresKey),
      smallScreen: SmallChild(featuresKey: featuresKey),
    );
  }
}

class LargeChild extends StatelessWidget {
  final GlobalKey featuresKey;
  const LargeChild({super.key, required this.featuresKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          key: const Key('home-section'),
          height: 600,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: .6,
                child: Image.asset(
                  'assets/piano.png',
                  fit: BoxFit.contain,
                ),
              ),
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: .6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Hello!",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8591B0),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: "Welcome To ",
                          style: TextStyle(fontSize: 50, color: Color(0xFF8591B0)),
                          children: [
                            TextSpan(
                              text: "Piano World",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, top: 20),
                        child: Text(
                          "LET’S EXPLORE THE WORLD",
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Search(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          key: const Key('products-section'),
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Our Products",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Discover our best products to elevate your piano experience.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 1200 ? 3 : 2;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return ProductCard(
                        name: product['name']!,
                        description: product['description']!,
                        image: product['image']!,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 60),
              FuturesSection(key: featuresKey),
            ],
          ),
        ),
      ],
    );
  }
}

class SmallChild extends StatelessWidget {
  final GlobalKey featuresKey;
  const SmallChild({super.key, required this.featuresKey});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Hello!",
            style: TextStyle(
              fontSize: 40,
              color: Color(0xFF8591B0),
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            text: const TextSpan(
              text: 'Welcome To ',
              style: TextStyle(fontSize: 40, color: Color(0xFF8591B0)),
              children: <TextSpan>[
                TextSpan(
                  text: 'Piano World',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12.0, top: 20),
            child: Text(
              "LET’S EXPLORE THE WORLD",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Image.asset(
              "assets/piano.png",
              fit: BoxFit.contain,
              height: 200,
            ),
          ),
          const SizedBox(height: 32),
          Search(),
          const SizedBox(height: 30),
          const Text(
            "Our Products",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Discover our best products to elevate your piano experience.",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              return ProductCard(
                name: product['name']!,
                description: product['description']!,
                image: product['image']!,
              );
            },
          ),
          const SizedBox(height: 60),
          FuturesSection(key: featuresKey),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 120,
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
