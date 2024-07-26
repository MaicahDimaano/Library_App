import 'package:flutter/material.dart';
import 'package:library_app/screens/bottom_nav_bar.dart';
import 'package:library_app/screens/home/authentication/login.dart';
import 'package:library_app/screens/home/authentication/register.dart';
import 'package:library_app/screens/home/components/read_now.dart';
import 'package:library_app/screens/home/home_page.dart';
import 'package:library_app/screens/user_account/user_account.dart';
import 'package:library_app/screens/home/pages/book_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookQuest',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.nameRoute,
      routes: {
        LoginPage.nameRoute: (context) => LoginPage(),
        RegisterPage.nameRoute: (context) => RegisterPage(),
        BottomNavBar.nameRoute: (context) => const BottomNavBar(),
        HomePage.nameRoute: (context) => const HomePage(),
        UserProfile.nameRoute: (context) => UserProfile(),
        BookDetail.nameRoute: (context) => BookDetail(),
        ReadingPage.nameRoute: (context) => ReadingPage(scaffoldKey: scaffoldKey),
      },
    );
  }
}
