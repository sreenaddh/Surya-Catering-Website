import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(CateringWebsite());
}

class CateringWebsite extends StatelessWidget {
  const CateringWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Surya Catering | Events | Decor ',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  bool _isSecondSection = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      double secondSectionOffset = MediaQuery.of(context).size.height;
      _isSecondSection = _scrollOffset >= secondSectionOffset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          backgroundColor: _isSecondSection ? Colors.white : Colors.transparent,
          elevation: 0,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                // Show a menu icon for smaller screens
                return Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      IconButton(
                        icon: Icon(Icons.menu,
                            color:
                                _isSecondSection ? Colors.black : Colors.white),
                        onPressed: () {
                          showMenu(
                            context: context,
                            position:
                                RelativeRect.fromLTRB(0, kToolbarHeight, 0, 0),
                            items: [
                              PopupMenuItem(
                                child: Text('Menu'),
                                onTap: () => _scrollController.animateTo(
                                  MediaQuery.of(context).size.height * 2,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut,
                                ),
                              ),
                              PopupMenuItem(
                                child: Text('Services'),
                                onTap: () => _scrollController.animateTo(
                                  MediaQuery.of(context).size.height * 5,
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.easeInOut,
                                ),
                              ),
                              PopupMenuItem(
                                child: Text('About Us'),
                                onTap: () => _scrollController.animateTo(
                                  MediaQuery.of(context).size.height * 3,
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.easeInOut,
                                ),
                              ),
                              PopupMenuItem(
                                child: Text('Contact'),
                                onTap: () => _scrollController.animateTo(
                                  MediaQuery.of(context).size.height * 6,
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.easeInOut,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Image(
                        image: AssetImage(_isSecondSection
                            ? 'assets/logoblack.png'
                            : 'assets/logo.png'),
                        height: 35,
                      ),
                    ]));
              } else {
                // Show the full menu for larger screens
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 16.0,
                        children: [
                          TextButton(
                            onPressed: () => _scrollController.animateTo(
                              MediaQuery.of(context).size.height * 2,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                            ),
                            child: Text(
                              'Menu',
                              style: TextStyle(
                                color: _isSecondSection
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _scrollController.animateTo(
                              MediaQuery.of(context).size.height * 5,
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInOut,
                            ),
                            child: Text(
                              'Services',
                              style: TextStyle(
                                color: _isSecondSection
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Image(
                              image: AssetImage(_isSecondSection
                                  ? 'assets/logoblack.png'
                                  : 'assets/logo.png'),
                              height: 55,
                            ),
                          ),
                          TextButton(
                            onPressed: () => _scrollController.animateTo(
                              MediaQuery.of(context).size.height * 3,
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInOut,
                            ),
                            child: Text(
                              'About Us',
                              style: TextStyle(
                                color: _isSecondSection
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _scrollController.animateTo(
                              MediaQuery.of(context).size.height * 6,
                              duration: const Duration(seconds: 2),
                              curve: Curves.easeInOut,
                            ),
                            child: Text(
                              'Contact',
                              style: TextStyle(
                                color: _isSecondSection
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Transform.translate(
              offset: Offset(0, -_scrollOffset * 0.4),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  stops: const [0.0, 0.2, 1.0],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, bottom: 100.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Special Occasions Deserve',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045 > 33
                                      ? MediaQuery.of(context).size.width *
                                          0.045
                                      : 33,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: const Offset(1, 1),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Special Food',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045 > 33
                                      ? MediaQuery.of(context).size.width *
                                          0.045
                                      : 33,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: const Offset(1, 1),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Crafted with Care for Moments That Matter Most!',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.022 > 18
                                      ? MediaQuery.of(context).size.width *
                                          0.022
                                      : 18,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: const Offset(1, 1),
                                  blurRadius: 2.0,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Parallax background image
                      Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(0, 0), // Adjust parallax speed here
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/bg2.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Shadow gradient at the top
                      Container(
                        height: 50, // Adjust height to control shadow spread
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // Main content of the second section, aligned to center
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Where Flavors Meet \nTradition',
                                style: GoogleFonts.bodoniModa(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 45,
                                  color: Color.fromARGB(255, 255, 86, 34),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'At Surya Catering, we believe that food is more than just a meal\nit\'s an experience that brings people together. '
                                'With years of expertise\nin crafting delicious, authentic cuisine, we\'re dedicated to making\nyour event unforgettable.',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: 'Pristina',
                                  color: Color.fromARGB(221, 0, 0, 0),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

// New third section with the menu and gallery
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (MediaQuery.of(context).size.width > 1600)
                          const SizedBox(
                              height: 75), // Only for larger displays
                        // Section Title
                        Text(
                          'Our Menu',
                          style: GoogleFonts.bodoniModa(
                            fontWeight: FontWeight.w700,
                            fontSize: 45,
                            color: Color.fromARGB(255, 255, 86, 34),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Within these pages, discover our extensive range of catering services, from traditional South Indian cuisine to innovative fusion dishes.',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 28,
                                    fontFamily: 'Pristina',
                                    color: const Color.fromARGB(221, 0, 0, 0),
                                    height: 1.5,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Add your menu and gallery content here
                        ImageGalleryScreen(),
                      ],
                    ),
                  ),
                ),

                // New fourth section with a title
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg4.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Section Title
                        Text(
                          'Our Story',
                          style: GoogleFonts.bodoniModa(
                            fontWeight: FontWeight.w700,
                            fontSize: 45,
                            color: Color.fromARGB(255, 255, 86, 34),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Founded on the principles of quality, taste, and tradition, Surya Catering has established \nitself as a leading catering service in Kottayam. Our team of skilled chefs and hospitality experts share \na passion for creating memorable dining experiences that reflect the warmth and richness of Indian culture.',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 28,
                                    fontFamily: 'Pristina',
                                    color: const Color.fromARGB(221, 0, 0, 0),
                                    height: 1.5,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

// New fifth section with the title "Why Choose Us"
                Container(
                  height: MediaQuery.of(context).size.width > 600
                      ? MediaQuery.of(context)
                          .size
                          .height // Full viewport height for large screens
                      : null, // Adaptive height for smaller screens based on content
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/blackbg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Section Title
                        LayoutBuilder(
                          builder: (context, constraints) {
                            double titleFontSize =
                                constraints.maxWidth > 600 ? 45 : 30;
                            double bodyFontSize =
                                constraints.maxWidth > 600 ? 28 : 20;

                            return Column(
                              children: [
                                Text(
                                  'Why Choose Us',
                                  style: GoogleFonts.bodoniModa(
                                    fontWeight: FontWeight.w700,
                                    fontSize: titleFontSize,
                                    color: Color.fromARGB(255, 255, 86, 34),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Discover our extensive range of catering services, from traditional South Indian cuisine to innovative fusion dishes.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: bodyFontSize,
                                        fontFamily: 'Pristina',
                                        color: const Color.fromARGB(
                                            221, 255, 255, 255),
                                        height: 1.5,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        ),

                        // Feature Boxes using Wrap for responsiveness
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 20.0, // Horizontal spacing between items
                              runSpacing: 20.0, // Vertical spacing between rows
                              children: [
                                _buildFeatureBox(
                                    Icons.menu, "Customizable menus"),
                                _buildFeatureBox(
                                    Icons.event, "Expert event planning"),
                                _buildFeatureBox(
                                    Icons.person, "Professional service staff"),
                                _buildFeatureBox(Icons.verified,
                                    "Commitment to quality and hygiene"),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

// Sixth section "Our Services"with the menu and gallery
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 75),
                        // Section Title
                        Text(
                          "Our Services",
                          style: GoogleFonts.bodoniModa(
                            fontWeight: FontWeight.w700,
                            fontSize: 45,
                            color: Color.fromARGB(255, 255, 86, 34),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Discover our extensive range of catering services',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 28,
                                    fontFamily: 'Pristina',
                                    color: const Color.fromARGB(221, 0, 0, 0),
                                    height: 1.5,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        // Add your menu and gallery content here
                        ImageGalleryScreen2(),
                      ],
                    ),
                  ),
                ),

// Seventh section - Contact Us
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg3.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        // Section Title
                        Text(
                          'Contact Us',
                          style: GoogleFonts.bodoniModa(
                            fontWeight: FontWeight.w700,
                            fontSize: 45,
                            color: Color.fromARGB(255, 255, 86, 34),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // Contact Information
                        Column(
                          children: [
                            _buildContactInfo(
                              icon: Icons.phone,
                              title: 'Call Us',
                              subtitle1: '9961280600',
                              subtitle2: '6238001719',
                            ),
                            const SizedBox(height: 30),
                            _buildContactInfo(
                                icon: Icons.email,
                                title: 'Email Us',
                                subtitle1: 'info@suryacatering.com',
                                subtitle2: 'support@suryacatering.com'),
                            const SizedBox(height: 30),
                            _buildContactInfo(
                              icon: Icons.location_on,
                              title: 'Our Location',
                              subtitle1: 'Surya Catering, Thalanadu',
                              subtitle2: 'Kottayam, Kerala, India',
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Contact Form Button
                      ],
                    ),
                  ),
                ),

// Change the footer section background to blackbg.png
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/blackbg.png'), // Use blackbg.png as background
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        '© 2024 Surya Catering. All Rights Reserved.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Follow us on social media',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.facebook, color: Colors.white),
                            onPressed: () {
                              // Add your Facebook link here
                            },
                          ),
                          // Additional social media buttons can be added here
                        ],
                      ),
                    ],
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

// Helper method to build contact information
Widget _buildContactInfo({
  required IconData icon,
  required String title,
  required String subtitle1,
  required String subtitle2,
}) {
  return Container(
    width: 500,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, size: 40, color: Color.fromARGB(255, 255, 86, 34)),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle1,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            Text(
              subtitle2,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper method to build feature boxes
Widget _buildFeatureBox(IconData icon, String text) {
  return Container(
    width: 300,
    height: 300, // Set a fixed width for the boxes
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(0, 255, 255, 255),
      //borderRadius: BorderRadius.circular(12),
      border: Border.all(width: 5.0, color: const Color(0xFFFFFFFF)),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Color.fromARGB(255, 255, 255, 255)),
        const SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    ),
  );
}

class ImageGalleryScreen extends StatefulWidget {
  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  late ScrollController _scrollController;
  double mouseDownAt = 0;
  double prevScrollOffset = 0;
  int? _hoveredIndex;

  List<Map<String, String>> _images = [
    {
      'url': 'https://i.ibb.co/GQrm1fW/vegsadya.jpg',
      'description': 'VEGETARIAN SADYA',
      'detailedDescription':
          '🌿 Vegetarian Sadya:\n\nMain Items:\n- Sadhya Rice\n- Parippu\n- Ghee\n- Sambar\n- Kalan\n- Aviyal\n- Thoran\n- Erissery\n- Koottu Curry\n- Inchi Curry\n- Puli Inchi\n- Mango Pickle\n- Lemon Pickle\n- Madhura Curry\n- Mezhuku Varatti\n- Chips\n- Sharkkara Varatti\n- Pazham\n- Pappadam\n\nDesserts:\n- Payasam\n- Pradhaman\n- Semiya Payasam'
    },
    {
      'url': 'https://i.ibb.co/3kCWyCk/firstcourse.jpg',
      'description': 'FIRST COURSE',
      'detailedDescription':
          '🍛 First Course:\n\nVegetarian Curry Options:\n- Kadala Curry\n- Potato Curry\n- Veg Curry\n- Veg Kuruma\n- Paneer Curry\n- Paneer Makni\n- Green Peas Curry\n- Sambar\n\nNon-Vegetarian Curry Options:\n- Nadan Chicken Curry\n- Chicken Stew\n- Mutton Stew\n- Duck Mappas\n- Chicken Varutharachathu\n- Chettinadu Chicken\n- Fish Molly\n- Fish Curry Kerala Style\n- Fish Nirvana\n- Prawns Curry\n- Nadan Beef Curry\n- Beef Stew\n- Beef Mappas\n- Chettinadu Beef\n- Beef Roast\n- Chicken Roast'
    },
    {
      'url': 'https://i.ibb.co/7Sszcbm/combo.png',
      'description': 'SURYA SPECIAL COMBO',
      'detailedDescription':
          '✨ Surya Special Combo:\n\nWelcome Drinks:\n- Two Types of Fresh Juice\n\nStarters:\n- Chicken Nuggets\n- Gobi Manchurian\n- Chicken Lollypop\n\nFirst Course:\n- Appam with Mutton Stew or Duck Mappas\n\nMain Course:\n- Kerala Rice\n- Cabbage Thoran\n- Kalan\n- Beef Fry\n- Thoran\n- Aviyal\n- Chicken 65\n- Fish Curry\n\nDesserts:\n- Fruit Salad\n- Gulab Jamun\n- Vanilla Ice Cream Scooping'
    },
    {
      'url': 'https://i.ibb.co/xLKNT0H/salad-Small.jpg',
      'description': 'SALADS',
      'detailedDescription':
          '🥗 Salads:\n\nTraditional Kerala Salads:\n- Pachadi\n- Kichadi\n- Vellarikka Salad\n- Inchi Curry Salad\n\nFruit Salads:\n- Kerala Fruit Salad\n- Coconut Fruit Salad\n- Spiced Fruit Salad\n\nVegetable Salads:\n- Carrot & Beetroot Salad\n- Cucumber & Tomato Salad\n- Kerala Style Coleslaw\n\nModern Kerala Salads:\n- Avocado & Mango Salad\n- Grilled Vegetable Salad\n\nSalad Dressings:\n- Coconut-Cilantro Dressing\n- Lime-Cumin Dressing\n- Spiced Coconut Oil Dressing\n\nGarnishes:\n- Fresh Cilantro\n- Grated Coconut\n- Fried Onions\n- Chopped Nuts (Cashew, Almond)\n\nRegional Inspirations:\n- Malabar Style Salad\n- Travancore Style Salad\n- Kochi Style Salad'
    },
    {
      'url': 'https://i.ibb.co/2k3Vjnw/dessert.jpg',
      'description': 'DESSERTS',
      'detailedDescription':
          '🍨 Desserts:\n\nClassic Flavours:\n- Wedding Cake\n- Gulab Jamun\n- Jalebi\n- Ice Cream Varieties (Scooping, Piece Serving)\n- Personalized Desserts (e.g., Photocake)\n- Donuts\n- Brownies\n\nPopular Ice Cream Flavours:\n- Vanilla\n- Chocolate\n- Strawberry\n- Cookies & Cream\n- Pineapple\n- Raspberry\n- Blueberry\n- Butterscotch\n- Karikku\n- Jackfruit'
    },
    {
      'url': 'https://i.ibb.co/GWbKHvj/starter.png',
      'description': 'STARTERS',
      'detailedDescription':
          '🍢 Starters:\n\nVegetarian Starters:\n- Samosa\n- Onion Pakoda\n- Medhu Vada\n- Ulli Vada\n- Parippu Vada\n- Banana Fry\n- Veg Pakoda\n- Potato Bonda\n- Unnakkaya\n- Gobi Manchurian\n- Chilli Paneer\n- Veg Momos\n\nNon-Vegetarian Starters:\n- Chicken Lollypop\n- Chicken 65\n- Chilli Chicken\n- Chicken Tikka\n- Fish Fry\n- Chicken Tenders\n- Chicken Nuggets\n- Momos\n- Chilli Prawns\n- Fish Fingers\n- Chicken Pakoda\n- Chicken Dry Fry'
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void handleOnDown(DragStartDetails details) {
    mouseDownAt = details.globalPosition.dx;
    prevScrollOffset = _scrollController.offset;
  }

  void handleOnMove(DragUpdateDetails details) {
    double deltaX = mouseDownAt - details.globalPosition.dx;
    double maxScrollDelta = MediaQuery.of(context).size.width;
    double scrollAmount = (deltaX / maxScrollDelta) * 200;
    _scrollController.jumpTo((prevScrollOffset + scrollAmount)
        .clamp(0.0, _scrollController.position.maxScrollExtent));
  }

  void handleOnUp(DragEndDetails details) {
    mouseDownAt = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) {
      return Center(child: Text("No images available"));
    }

    return GestureDetector(
      onPanStart: handleOnDown,
      onPanUpdate: handleOnMove,
      onPanEnd: handleOnUp,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _images.map((imageData) {
            return MouseRegion(
              onEnter: (_) =>
                  setState(() => _hoveredIndex = _images.indexOf(imageData)),
              onExit: (_) => setState(() => _hoveredIndex = null),
              child: Transform.scale(
                scale: _hoveredIndex == _images.indexOf(imageData) ? 1.05 : 1.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageCard(
                    imageUrl: imageData['url']!,
                    description: imageData['description']!,
                    detailedDescription: imageData['detailedDescription']!,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String detailedDescription;

  const ImageCard({
    Key? key,
    required this.imageUrl,
    required this.description,
    required this.detailedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailScreen(
              imageUrl: imageUrl,
              description: description,
              detailedDescription: detailedDescription,
            ),
          ),
        );
      },
      child: Container(
        width: 300,
        height: 400,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Use Image.network for remote images
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(Icons.error, color: Colors.red, size: 50),
                    );
                  },
                ),
                // Overlay and Description Text
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Text(
                    description,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Assuming the ImageDetailScreen is defined as follows
class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String detailedDescription;

  const ImageDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.description,
    required this.detailedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          _buildImageDetails(),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
        expandedHeight: 400.0,
        floating: true,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            description,
            style: _appBarTitleStyle(),
            textAlign: TextAlign.center,
          ),
          background: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(),
              Positioned(
                top: 16.0, // Adjust this value for top spacing
                left: 60.0, // Adjust this value for left positioning
                child: Image.asset(
                  'assets/logo.png',
                  width: 100, // Adjust based on your logo's dimensions
                  height: 50, // Adjust based on your logo's dimensions
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(top: 20),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Colors.white), // Back button in white
            onPressed: () {
              Navigator.of(context).pop(); // Go back to the previous screen
            },
          ),
        ));
  }

  TextStyle _appBarTitleStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          blurRadius: 10.0,
          color: Colors.black,
          offset: Offset(2.0, 2.0),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
            size: 50,
          ),
        );
      },
    );
  }

  SliverToBoxAdapter _buildImageDetails() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailsDescription(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0), // Add padding around the description
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          // Main Description with Rich Styling
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color for contrast
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0), // Padding inside the container
            child: Text(
              detailedDescription,
              style: TextStyle(
                fontSize: 18,
                height: 1.6,
                color: Colors.black.withOpacity(0.8),
                fontFamily: 'Roboto',
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Decorative Divider
          Center(
            child: Container(
              height: 3,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Sixth section image cards

class ImageGalleryScreen2 extends StatefulWidget {
  @override
  _ImageGalleryScreen2State createState() => _ImageGalleryScreen2State();
}

class _ImageGalleryScreen2State extends State<ImageGalleryScreen2> {
  late ScrollController _scrollController;
  double mouseDownAt = 0;
  double prevScrollOffset = 0;
  int? _hoveredIndex;

  // Local images for this gallery
  List<Map<String, String>> _images = [
    {
      'url': 'https://i.ibb.co/SQvZcH5/maincourse.jpg',
      'description': 'MAIN COURSE',
      'detailedDescription':
          '🍴 Main Course:\n\nRice Varieties:\n- Kerala Matta Rice\n- Pulavu Rice\n- Ghee Rice\n- Fried Rice\n- Chicken Fried Rice\n- Veg Fried Rice\n- Schezwan Fried Rice\n- Prawns Fried Rice\n- Manthi Rice\n\nBiryani Options:\n- Malabar Biryani (Chicken/Mutton)\n- Kottayam Style Biryani (Chicken/Mutton)\n- Thalappakatty Biryani (Chicken/Mutton)\n\nMeat & Fish Specialties:\n- Beef Dry Fry\n- Beef Fry\n- Beef Ularthiyathu\n- Mutton Fry Roast\n- Chicken Fry\n- Chicken Dry Fry'
    },
    {
      'url': 'https://i.ibb.co/Gp7nCdL/weldrink.jpg',
      'description': 'WELCOME DRINKS',
      'detailedDescription':
          '🍹 Welcome Drinks:\n\nJuices:\n- Musambi\n- Orange\n- Pineapple\n- Watermelon\n- Papaya\n- Mango\n- Grape\n- Mixed Fruit\n- Apple\n- Chikku\n- Lime\n- Grape Lime\n- Fresh Lime\n- Ginger Lime\n- Mint Lime\n\nLassi:\n- Sweet Lassi\n- Fruit Lassi\n- Mango Lassi\n- Vanilla Lassi\n- Mint Lassi\n- Banana Lassi\n\nTea:\n- Black Tea\n- Mint Tea\n- Ginger Tea\n- Masala Tea\n- Green Tea\n- Lime Tea\n- Sweet Tea (cola)\n- Cold Boost\n- Chocolate Coffee\n- Rose Tea\n- Boost\n- Cardamom Tea\n- Normal Tea\n- Sulaimani\n- Herbal Tea\n\nSoda Drinks:\n- Sprite\n- Coca Cola\n- Jeera Soda\n- Strawberry Soda\n- Kiwi Soda\n- Pepsi'
    },
    {
      'url': 'https://i.ibb.co/NSwnKpt/livecounters.jpg',
      'description': 'LIVE COUNTERS',
      'detailedDescription':
          '🔥 Live Counters:\n\nVeg Live Counters:\n- Appam Station\n- Idiyappam Station\n- Puttu Station\n- Dosha Station\n- Idli Station\n- Porotta Station\n\nNon-Veg Live Counters:\n- Kothu Porotta Station\n- Grill Station\n- Fish Fry Station\n- Fish Grilled\n- Mutton Biryani Station\n- Fried Rice Station\n- Fish Pollichathu'
    }
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void handleOnDown(DragStartDetails details) {
    mouseDownAt = details.globalPosition.dx;
    prevScrollOffset = _scrollController.offset;
  }

  void handleOnMove(DragUpdateDetails details) {
    double deltaX = mouseDownAt - details.globalPosition.dx;
    double maxScrollDelta = MediaQuery.of(context).size.width;
    double scrollAmount = (deltaX / maxScrollDelta) * 200;
    _scrollController.jumpTo((prevScrollOffset + scrollAmount)
        .clamp(0.0, _scrollController.position.maxScrollExtent));
  }

  void handleOnUp(DragEndDetails details) {
    mouseDownAt = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) {
      return Center(child: Text("No images available"));
    }

    return GestureDetector(
      onPanStart: handleOnDown,
      onPanUpdate: handleOnMove,
      onPanEnd: handleOnUp,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _images.map((imageData) {
            return MouseRegion(
              onEnter: (_) =>
                  setState(() => _hoveredIndex = _images.indexOf(imageData)),
              onExit: (_) => setState(() => _hoveredIndex = null),
              child: Transform.scale(
                scale: _hoveredIndex == _images.indexOf(imageData) ? 1.05 : 1.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageCard2(
                    imageUrl: imageData['url']!,
                    description: imageData['description']!,
                    detailedDescription: imageData['detailedDescription']!,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class ImageCard2 extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String detailedDescription;

  const ImageCard2({
    Key? key,
    required this.imageUrl,
    required this.description,
    required this.detailedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailScreen(
              imageUrl: imageUrl,
              description: description,
              detailedDescription: detailedDescription,
            ),
          ),
        );
      },
      child: Container(
        width: 300,
        height: 400,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Use Image.network for remote images
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(Icons.error, color: Colors.red, size: 50),
                    );
                  },
                ),
                // Overlay and Description Text
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Text(
                    description,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
