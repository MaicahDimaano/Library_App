import 'package:flutter/material.dart';
import 'package:library_app/screens/home/pages/bookTileSave.dart'; // Replace with actual import path
import 'package:library_app/themes.dart'; // Import your themes.dart file

class SavePage extends StatefulWidget {
  static const nameRoute = '/savePage';

  const SavePage({Key? key}) : super(key: key);

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  // Sample data
  List<Map<String, dynamic>> libraryBooks = [
    {
      'image': 'assets/images/recent1.png',
      'title': 'Situation of the Story',
      'author': 'Diana Young',
      'progress': 0.3,
    },
    {
      'image': 'assets/images/recent2.png',
      'title': 'Realm of Ice',
      'author': 'Angela J. Ford',
      'progress': 0.5, 
    },
    {
      'image': 'assets/images/recent3.png',
      'title': 'Fallen Gates',
      'author': 'G. M. Gabriels',
      'progress': 0.75, 
    },
    {
      'image': 'assets/images/recent4.png',
      'title': 'Children of Time',
      'author': 'Adrian Tchaikovsky',
      'progress': 0.45, 
    },
    {
      'image': 'assets/images/recent5.png',
      'title': 'Ancillary Justice',
      'author': 'Ann Leckie',
      'progress': 0.5, 
    },
    {
      'image': 'assets/images/recent6.png',
      'title': 'Oryx and Crake',
      'author': 'Margaret Atwood',
      'progress': 0.25, 
    },
    {
      'image': 'assets/images/recent7.png',
      'title': 'Flowers for Algernon',
      'author': 'Daniel Keyes',
      'progress': 0.50, 
    },
    {
      'image': 'assets/images/recent8.png',
      'title': 'Station Eleven',
      'author': 'Emely St. John Mandel',
      'progress': 0.90, 
    },
    {
      'image': 'assets/images/recent9.png',
      'title': 'Doomsday Book',
      'author': 'Connie Willis',
      'progress': 0.25, 
    },
    {
      'image': 'assets/images/recent10.png',
      'title': 'The Man Who Fell to Earth',
      'author': 'Walter Tevis',
      'progress': 0.35, 
    },
    {
      'image': 'assets/images/recent11.png',
      'title': 'Ringworld',
      'author': 'Larry Niven',
      'progress': 0.75, 
    },
    {
      'image': 'assets/images/recent12.png',
      'title': 'Ugly Love',
      'author': 'Colleen Hoover',
      'progress': 0.25, 
    },
    {
      'image': 'assets/images/recent13.png',
      'title': 'Confess',
      'author': 'Colleen Hoover',
      'progress': 0.90, 
    },
    {
      'image': 'assets/images/recent14.png',
      'title': 'Too Late',
      'author': 'Colleen Hoover',
      'progress': 0.90, 
    },
  ];

  List<Map<String, dynamic>> archiveBooks = [
    {
      'image': 'assets/trending/tr1.png',
      'title': 'The Time Machine',
      'author': 'H. G. Wells',
      'progress': 1.0, 
    },
    {
      'image': 'assets/trending/tr2.png',
      'title': 'The Hitch-Hiker\'s Guide to the Galaxy',
      'author': 'Douglas Adams',
      'progress': 0.1, 
    },
    {
      'image': 'assets/trending/tr3.png',
      'title': 'Dune',
      'author': 'Frank Herbert',
      'progress': 1.0, 
    },
    {
      'image': 'assets/trending/tr4.png',
      'title': 'Ready Player One',
      'author': 'Ernest Clime',
      'progress': 0.85, 
    },
    {
      'image': 'assets/trending/tr5.png',
      'title': 'The Marcian',
      'author': 'Andy Weir',
      'progress': 0.90, 
    },
    {
      'image': 'assets/trending/tr6.png',
      'title': '1984',
      'author': 'George Orwell',
      'progress': 1.0,
    },
    {
      'image': 'assets/trending/tr7.png',
      'title': 'Frankenstein',
      'author': 'Mary Shelley',
      'progress': 0.97, 
    },
    {
      'image': 'assets/trending/tr8.png',
      'title': 'Brave New World',
      'author': 'Aldous Huxley',
      'progress': 0.84, 
    },
    {
      'image': 'assets/trending/tr9.png',
      'title': '2001 A Space Odyssey',
      'author': 'Arthur C. Clarke',
      'progress': 0.98, 
    },
    {
      'image': 'assets/trending/tr10.png',
      'title': 'Binti',
      'author': 'Nnedi Okorafor',
      'progress': 0.79, 
    },
    {
      'image': 'assets/trending/tr11.png',
      'title': 'Hyperion',
      'author': 'Dan Simmons',
      'progress': 0.79, 
    },
  ];

  void _sortBooks(String criteria) {
    setState(() {
      if (criteria == 'Title') {
        libraryBooks.sort((a, b) => a['title'].compareTo(b['title']));
        archiveBooks.sort((a, b) => a['title'].compareTo(b['title']));
      } else if (criteria == 'Author') {
        libraryBooks.sort((a, b) => a['author'].compareTo(b['author']));
        archiveBooks.sort((a, b) => a['author'].compareTo(b['author']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          backgroundColor: whiteColor,
          actions: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                _sortBooks(value);
              },
              itemBuilder: (BuildContext context) {
                return {'Title', 'Author'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text('Sort by $choice'),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: greenColor, 
            labelColor:
                greenColor,
            unselectedLabelColor:
                greyColor, 
            tabs: [
              Tab(text: 'Recent'),
              Tab(text: 'Archive'),
            ],
          ),
        ),
        body: Container(
          color: backgroundColor, // Set background color to white
          child: TabBarView(
            children: [
              // Tab View for Library
              GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 0.5, 
                ),
                itemCount: libraryBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return BookTile(
                    image: libraryBooks[index]['image']!,
                    progress: libraryBooks[index]['progress'] ?? 0.0,
                    title: libraryBooks[index]['title']!,
                  );
                },
              ),
              // Tab View for Archive
              GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.5, 
                ),
                itemCount: archiveBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return BookTile(
                    image: archiveBooks[index]['image']!,
                    progress: archiveBooks[index]['progress'] ?? 0.0,
                    title: archiveBooks[index]['title']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
