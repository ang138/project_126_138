
import 'package:flutter/material.dart';
import 'package:project/pages/booking.dart';
import 'package:project/pages/home.dart';
import 'package:project/pages/profile.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;
  final screens = [
    HomaPage(),
    BookingPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          iconSize: 35,
          // selectedFontSize: 23,
          // unselectedFontSize: 18,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              // backgroundColor: Colors.blue,
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.domain_add),
              label: 'Booking',
              // backgroundColor: Colors.blue,
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              // backgroundColor: Colors.blue,
              ),
          ],
          ),
      
    );
  }
}
