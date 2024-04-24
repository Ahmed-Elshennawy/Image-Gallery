import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 35),
        title: const Text(
          'Discover',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchDelegator(),
              );
            },
          ),
          const SizedBox(width: 20),
          const Icon(Icons.filter_list),
          const SizedBox(width: 20),
        ],
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  MyCustomWidget(
                    imageUrl:
                        'https://picsum.photos/${1080 + index}/${(index % 2 + 1) * 1209}',
                  ),
                ],
              );
            },
          ),
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
}

class SearchDelegator extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          itemBuilder: (context, index) {
            switch (query.toLowerCase()) {
              case 'nature':
                return MyCustomWidget(
                  imageUrl:
                      'https://picsum.photos/${670 + index}/${(index % 2 + 1) * 230}',
                );
              case 'morning':
                return MyCustomWidget(
                  imageUrl:
                      'https://picsum.photos/${834 + index}/${(index % 2 + 1) * 230}',
                );
              case 'people':
                return MyCustomWidget(
                  imageUrl:
                      'https://picsum.photos/${769 + index}/${(index % 2 + 1) * 398}',
                );
              default:
                return MyCustomWidget(
                  imageUrl:
                      'https://picsum.photos/${1080 + index}/${(index % 2 + 1) * 1209}',
                );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = ['nature', 'morning', 'people'];
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class MyCustomWidget extends StatelessWidget {
  final String imageUrl;

  const MyCustomWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(imageUrl: imageUrl),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
