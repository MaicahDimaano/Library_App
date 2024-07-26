import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/screens/home/pages/book_details.dart';
import 'package:library_app/themes.dart';

class TrendingBook extends StatelessWidget {
  const TrendingBook({
    Key? key,
    required this.info,
    required this.onBookAdded,
  }) : super(key: key);

  final BookList info;
  final void Function(Map<String, dynamic>) onBookAdded;

  @override
  Widget build(BuildContext context) {
    void _navigateToBookDetail() async {
      final result = await Navigator.pushNamed(
        context,
        BookDetail.nameRoute,
        arguments: {
          'title': info.title,
          'imageUrl': info.imageUrl,
          'description': info.description,
          'writers': info.writers,
          'rating': info.rating,
          'pages': info.pages,
          'language': info.language,
          'category': info.category,
        },
      );

      if (result != null && result is Map<String, dynamic>) {
        // Add the book to the library
        onBookAdded(result);
      }
    }

    return Container(
      margin: const EdgeInsets.only(top: 12, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _navigateToBookDetail,
            child: Hero(
              tag: info.imageUrl,
              child: Container(
                height: 160,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(info.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 120,
            child: Text(
              info.writers,
              style: mediumText12.copyWith(color: greyColor2),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              info.title,
              style: semiBoldText12.copyWith(color: blackColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
