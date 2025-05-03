import 'package:flutter/material.dart';
import 'utils/responsiveLayout.dart';
import 'widgets/navbar.dart';
import 'widgets/search.dart';

// List data produk piano yang akan ditampilkan di halaman
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
  runApp(MyApp()); // Fungsi utama untuk menjalankan aplikasi Flutter
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Landing Page', // Judul aplikasi
      debugShowCheckedModeBanner: false, // Menghilangkan banner DEBUG di pojok kanan atas
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema warna aplikasi
      ),
      home: HomePage(), // Halaman pertama yang ditampilkan saat aplikasi dibuka
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController(); // Untuk mengontrol scroll halaman

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang halaman
      body: SingleChildScrollView(
        controller: _scrollController, // Menambahkan scroll jika konten panjang
        child: Column( // Susun widget secara vertikal
          children: <Widget>[
            NavBar(scrollController: _scrollController), // Widget Navbar di bagian atas
            Body(), // Bagian utama konten halaman
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: LargeChild(), // Layout untuk layar besar (misal desktop)
      smallScreen: SmallChild(), // Layout untuk layar kecil (misal smartphone)
    );
  }
}

// Tampilan untuk layar besar (desktop/tablet)
class LargeChild extends StatelessWidget {
  const LargeChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          key: Key('home-section'),
          height: 600,
          child: Stack( // Menumpuk gambar dan teks
            fit: StackFit.expand,
            children: <Widget>[
              FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: .6, // Gambar akan ambil 60% lebar layar kanan
                child: Image.asset( // Menampilkan gambar dari assets
                  'assets/piano.png',
                  fit: BoxFit.contain,
                ),
              ),
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: .6, // Teks ambil 60% lebar layar kiri
                child: Padding(
                  padding: EdgeInsets.only(left: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Hello!", // Judul sambutan
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8591B0),
                        ),
                      ),
                      RichText( // Teks dengan style campuran (warna, tebal)
                        text: TextSpan(
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
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 20),
                        child: Text(
                          "LET’S EXPLORE THE WORLD", // Subjudul
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ),
                      SizedBox(height: 40),
                      Search(), // Widget custom untuk pencarian
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          key: Key('products-section'),
          padding: EdgeInsets.symmetric(horizontal: 48, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Our Products", // Judul bagian produk
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Discover our best products to elevate your piano experience.", // Deskripsi bagian produk
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              SizedBox(height: 40),
              LayoutBuilder( // Untuk menentukan jumlah kolom grid berdasarkan lebar layar
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 1200 ? 3 : 2; // Jika layar >1200px pakai 3 kolom, kalau tidak 2
                  return GridView.builder(
                    shrinkWrap: true, // Grid menyesuaikan ukuran isinya
                    physics: NeverScrollableScrollPhysics(), // Grid tidak scroll sendiri
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
            ],
          ),
        ),
      ],
    );
  }
}

// Tampilan untuk layar kecil (mobile)
class SmallChild extends StatelessWidget {
  const SmallChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Hello!", // Judul sambutan
            style: TextStyle(
              fontSize: 40,
              color: Color(0xFF8591B0),
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            text: TextSpan(
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
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 20),
            child: Text(
              "LET’S EXPLORE THE WORLD", // Subjudul
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: Image.asset( // Gambar untuk versi mobile
              "assets/piano.png",
              fit: BoxFit.contain,
              height: 200,
            ),
          ),
          SizedBox(height: 32),
          Search(), // Widget pencarian
          SizedBox(height: 30),
          Text(
            "Our Products", // Judul produk
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Discover our best products to elevate your piano experience.", // Deskripsi produk
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Grid dengan 2 kolom untuk mobile
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
        ],
      ),
    );
  }
}

// Widget kartu untuk menampilkan produk
class ProductCard extends StatelessWidget {
  final String name; // Nama produk
  final String description; // Deskripsi produk
  final String image; // Path gambar produk

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Bayangan kartu
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Sudut kartu membulat
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 120, // Batasi tinggi gambar
              child: Image.asset(image, fit: BoxFit.contain), // Tampilkan gambar
            ),
            const SizedBox(height: 10),
            Text(
              name, // Nama produk
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                description, // Deskripsi produk
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // Potong teks jika terlalu panjang
                maxLines: 3, // Maksimal 3 baris
              ),
            ),
          ],
        ),
      ),
    );
  }
}
