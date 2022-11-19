import 'package:flutter/material.dart';
import 'package:xedu/features/home/presentation/views/home_view.dart';
import 'package:xedu/features/profile/presentation/views/profile_view.dart';
import 'package:xedu/features/report/views/report_view.dart';

class NavigationBarView extends StatelessWidget {
  const NavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const NavigationBarScreen();
  }
}

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
    int _currentIndex = 0;

      final _item = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'Beranda',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.report_outlined),
        label: 'Lapor',
      ),BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        label: 'Beranda',
      )
    ];

    static const _pageItem = <Widget>[
      HomeView(),
      ReportView(),
      ProfileView(),
    ];

    void _onItemTapped(int index){
      setState(() {
        _currentIndex = index;
      });
    }

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      body: _pageItem[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _item,
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromRGBO(95, 0, 119, 1),
        backgroundColor: Colors.white,
      ),
    );
  }
}
