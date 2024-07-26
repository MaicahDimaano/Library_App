import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/screens/home/pages/read_progress.dart';
import 'package:library_app/themes.dart';

class ReadingPage extends StatefulWidget {
  static const nameRoute = '/readingPage';

  final GlobalKey<ScaffoldState> scaffoldKey;

  const ReadingPage({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final double maxScrollExtent = _scrollController.position.maxScrollExtent;
      final double currentScroll = _scrollController.position.pixels;
      setState(() {
        _progress = (currentScroll / maxScrollExtent).clamp(0.0, 1.0);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context)?.settings.arguments as String;
    final BookList book = bookLists.firstWhere((book) => book.title == title);

    List<String> chapters = List.generate(
      10, // Number of chapters
      (index) => 'Chapter ${index + 1}', // Chapter titles
    );

    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: blackColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          book.title,
          style: semiBoldText14.copyWith(color: blackColor),
        ),
        backgroundColor: greyColorInfo,
        actions: [
          IconButton(
            icon: Icon(Icons.comment, color: blackColor),
            onPressed: () {
              // Handle comment action
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: blackColor),
            onPressed: () {
              // Handle settings action
            },
          ),
          IconButton(
            icon: Icon(Icons.menu, color: blackColor),
            onPressed: () {
              widget.scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: greyColorInfo,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: semiBoldText20.copyWith(color: blackColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    book.writers,
                    style: regularText14.copyWith(color: blackColor2),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Chapters',
                style: semiBoldText16.copyWith(color: blackColor),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    chapters[index],
                    style: regularText12.copyWith(color: blackColor2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Prologue',
                            style: semiBoldText20.copyWith(color: blackColor2),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.visibility, color: blackColor, size: 13.0),
                              const SizedBox(width: 5),
                              Text('300k', style: regularText12.copyWith(color: blackColor)),
                              const SizedBox(width: 20),
                              Icon(Icons.star, color: blackColor, size: 13.0),
                              const SizedBox(width: 5),
                              Text('45', style: regularText12.copyWith(color: blackColor)),
                              const SizedBox(width: 20),
                              Icon(Icons.comment, color: blackColor, size: 13.0),
                              const SizedBox(width: 5),
                              Text('107k', style: regularText12.copyWith(color: blackColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Prologue",
                      style: regularText14.copyWith(color: blackColor),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      book.content,
                      style: regularText12.copyWith(color: blackColor),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CustomLinearProgressIndicator(
              value: _progress,
              backgroundColor: greyColor,
              valueColor: greenColor,
            ),
          ),
        ],
      ),
    );
  }
}
