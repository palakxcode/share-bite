import 'package:firstapp/constants/colors.dart';
import 'package:firstapp/screens/donate.dart';
import 'package:firstapp/screens/home_screen.dart';
import 'package:firstapp/screens/profile.dart';
import 'package:firstapp/screens/seek.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  final BottomNavigationBarItem item;
  final Widget screen;

  NavigationItem(this.item, this.screen);
}

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  List<NavigationItem> items = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    items = [
      _navigationItem(
          Icons.home_outlined, Icons.home, 'Home', const HomeScreen()),
      _navigationItem(
          Icons.add_box, Icons.question_answer, 'Donate', const DonateScreen()),
      _navigationItem(
          Icons.bookmark_outline, Icons.food_bank, 'Seek', const SeekScreen()),
      _navigationItem(
          Icons.person_outline, Icons.person, 'Profile', ProfileScreen()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: biteColorSecondary,
      bottomNavigationBar: _bottomNavigationBar(),
      body: items[_currentIndex].screen,
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: biteColorPrimary,
      selectedItemColor: biteColorSecondary,
      unselectedItemColor: biteColorSecondary.withAlpha(120),
      currentIndex: _currentIndex,
      onTap: _onTabTapped,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: items.map((item) => item.item).toList(),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  NavigationItem _navigationItem(
      IconData icon, IconData activeIcon, String label, Widget screen) {
    return NavigationItem(
      BottomNavigationBarItem(
        icon: Icon(icon),
        label: label,
        tooltip: label,
        backgroundColor: biteColorPrimary,
        activeIcon: Icon(activeIcon),
      ),
      screen,
    );
  }
}
