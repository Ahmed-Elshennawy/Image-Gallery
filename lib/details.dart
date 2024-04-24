import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        actions: const [
          Icon(Icons.star_outline),
          SizedBox(width: 20),
          Icon(CupertinoIcons.ellipsis_vertical),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                viewportFraction: 0.5,
                enlargeCenterPage: true,
              ),
              items: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                for (int i = 0; i < 10; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://picsum.photos/200/300?random=${2 * i * 4}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 25),
            _buildSection(
              title: 'Summary',
              content: 'Pellentesque pulvinar turpis veleas.',
            ),
            const SizedBox(height: 25),
            _buildSection(
              title: 'About Photographer',
              content:
                  'Ploter id convallis metus ultrices integ et elit libero. Nullam a nulla et ligula porttitor lobortis. Nunc auctor, est ut fermentum cursus.',
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 28), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.school, size: 28), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 28), label: ''),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 55.0, vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
