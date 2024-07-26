import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/screens/home/components/read_now.dart';
import 'package:library_app/themes.dart';

class BookDetail extends StatelessWidget {
  static const String nameRoute = '/bookDetails';

  BookDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map;

    Widget header() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left_rounded, size: 30),
            ),
            Text(
              'Book Details',
              style: semiBoldText14.copyWith(color: blackColor),
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
      );
    }

    Widget bookImage() {
      return Hero(
        tag: data['imageUrl'],
        child: Container(
          height: 267,
          width: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                data['imageUrl'],
              ),
            ),
          ),
        ),
      );
    }

    Widget infoDescription() {
      return Container(
        height: 60,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: greyColorInfo,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Rating',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                const SizedBox(height: 2),
                Text(
                  data['rating'].toString(),
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
            VerticalDivider(color: dividerColor, thickness: 2),
            Column(
              children: [
                Text(
                  'Number of Pages',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                const SizedBox(height: 2),
                Text(
                  '${data['pages']} Pages',
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
            VerticalDivider(color: dividerColor, thickness: 2),
            Column(
              children: [
                Text(
                  'Language',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                const SizedBox(height: 2),
                Text(
                  data['language'],
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget category() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: data['category'].map<Widget>((category) {
            return Chip(
              label: Text(
                category,
                style: regularText12.copyWith(color: whiteColor),
              ),
              backgroundColor: greenColor,
            );
          }).toList(),
        ),
      );
    }

    Widget bottomButtons() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(right: 10),
                child: TextButton.icon(
                  onPressed: () async {
                    // Show the loading dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(greenColor),
                              ),
                              const SizedBox(width: 20),
                              const Text('Loading...'),
                            ],
                          ),
                        );
                      },
                    );

                    await Future.delayed(const Duration(seconds: 2));

                    Navigator.pop(context);

                    // Navigate to the ReadingPage with the book title
                    Navigator.pushNamed(
                      context,
                      ReadingPage.nameRoute,
                      arguments: data['title'],
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: Icon(Icons.menu_book, color: whiteColor),
                  label: Text(
                    'Read Now',
                    style: semiBoldText14.copyWith(color: whiteColor),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(left: 10),
                child: TextButton.icon(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: Icon(Icons.library_add, color: whiteColor),
                  label: Text(
                    'Add to Library',
                    style: semiBoldText14.copyWith(color: whiteColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget description() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: semiBoldText20.copyWith(color: blackColor2),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data['writers'],
                        style: mediumText14.copyWith(color: greyColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: greenColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.bookmark, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Free Access',
                      style: mediumText14.copyWith(color: greenColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Description',
              style: semiBoldText14.copyWith(color: blackColor2),
            ),
            const SizedBox(height: 6),
            Text(
              data['description'],
              style: regularText12.copyWith(color: greyColor),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Text(
              'Genres',
              style: semiBoldText14.copyWith(color: blackColor2),
            ),
            category(),
            const SizedBox(height: 20),
            infoDescription(),
            bottomButtons(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              Center(child: bookImage()),
              description(),
            ],
          ),
        ],
      ),
    );
  }
}

void navigateToReadingPage(BuildContext context, String title) {
  Navigator.pushNamed(
    context,
    ReadingPage.nameRoute,
    arguments: title,
  );
}

//  navigating to the ReadingPage for the first book
