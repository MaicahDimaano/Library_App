import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart'; // Import your book model
import 'package:library_app/screens/home/components/recent_book.dart';
import 'package:library_app/screens/home/components/trending_book.dart';
import 'package:library_app/screens/save/save_page.dart';
import '../../themes.dart';

class HomePage extends StatefulWidget {
  static const nameRoute = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _categories = [
    'All Books',
    'Sci-Fi',
    'Mystery',
    'Fiction',
    'Romance',
    'Fantasy',
    'Adventure',
    'Suspense',
    'Non-Fiction',
    'Mental Health'
  ];

  int _isSelected = 0;
  String _searchQuery = '';
  List<Map<String, dynamic>> _libraryBooks = [];

  bool noBooksFound(List<BookList> books) {
    return books.isEmpty;
  }

  List<BookList> getFilteredBooks() {
    if (_categories[_isSelected] == 'All Books') {
      return bookLists
          .where((book) =>
              book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              book.writers.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    } else {
      return bookLists
          .where((book) =>
              book.category.contains(_categories[_isSelected]) &&
              (book.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  book.writers
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase())))
          .toList();
    }
  }

  void _handleBookAdded(Map<String, dynamic> book) {
    setState(() {
      _libraryBooks.add(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget searchField() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Find your Favorite Book or Author',
            hintStyle: mediumText12.copyWith(color: greyColor),
            fillColor: greyColorSearchField,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(18),
            suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget recentBook() {
      return const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            RecentBook(
              image: 'assets/images/recent1.png',
              title: 'The Fault in Our Stars',
              completionPercentage: 0.3,
            ),
            SizedBox(width: 5),
            RecentBook(
              image: 'assets/images/recent2.png',
              title: 'Realm of Ice',
              completionPercentage: 0.5,
            ),
            SizedBox(width: 5),
            RecentBook(
              image: 'assets/images/recent3.png',
              title: 'The Fallen Gates',
              completionPercentage: 0.75,
            ),
            SizedBox(width: 5),
            RecentBook(
              image: 'assets/images/recent4.png',
              title: 'Children of Time',
              completionPercentage: 0.45,
            ),
            SizedBox(width: 5),
            RecentBook(
              image: 'assets/images/recent5.png',
              title: 'Ancillary Justice',
              completionPercentage: 0.5,
            ),
            RecentBook(
              image: 'assets/images/recent6.png',
              title: 'Oryx and Crake',
              completionPercentage: 0.25,
            ),
            RecentBook(
              image: 'assets/images/recent7.png',
              title: 'Flowers for Algernon',
              completionPercentage: 0.50,
            ),
            RecentBook(
              image: 'assets/images/recent8.png',
              title: 'Station Eleven',
              completionPercentage: 0.90,
            ),
            RecentBook(
              image: 'assets/images/recent9.png',
              title: 'Doomsday Book',
              completionPercentage: 0.25,
            ),
            RecentBook(
              image: 'assets/images/recent10.png',
              title: 'The Man Who Fell to Earth',
              completionPercentage: 0.35,
            ),
          ],
        ),
      );
    }

    Widget categories(int index) {
      return InkWell(
        onTap: () {
          setState(() {
            _isSelected = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20, right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isSelected == index ? greenColor : transParentColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            _categories[index],
            style: semiBoldText14.copyWith(
                color: _isSelected == index ? whiteColor : greyColor),
          ),
        ),
      );
    }

    Widget listCategories() {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories
              .asMap()
              .entries
              .map((entry) => categories(entry.key))
              .toList(),
        ),
      );
    }

    Widget trendingBook() {
      List<BookList> filteredBooks = getFilteredBooks();

      return filteredBooks.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'No books or authors match your search.',
                  style: semiBoldText14.copyWith(color: Colors.red),
                ),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: filteredBooks
                    .map((book) => TrendingBook(
                          info: book,
                          onBookAdded: _handleBookAdded,
                        ))
                    .toList(),
              ),
            );
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                'assets/Picks/logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BookQuest',
                  style: semiBoldText16,
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 28,
              onPressed: () {
                Navigator.pushNamed(context, SavePage.nameRoute, arguments: _libraryBooks);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor ,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  const SizedBox(height: 30),
                  searchField(),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Recent Books',
                      style: semiBoldText16.copyWith(color: blackColor),
                    ),
                  ),
                  const SizedBox(height: 12),
                  recentBook(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Categories',
                style: semiBoldText16.copyWith(color: blackColor),
              ),
            ),
            listCategories(),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30),
              child: Text(
                'Trending Now (${_categories[_isSelected]})',
                style: semiBoldText16.copyWith(color: blackColor),
              ),
            ),
            trendingBook(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
