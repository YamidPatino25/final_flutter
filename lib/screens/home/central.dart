import 'package:flutter/material.dart';
import 'package:final_flutter/screens/friends/friends.dart';
import 'package:final_flutter/screens/home/home.dart';

class Central extends StatefulWidget {
  @override
  _CentralState createState() => _CentralState();
}

class _CentralState extends State<Central> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _children = [Home(), Friends()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: navBar(),
        body: _children[_selectedIndex]);
  }

  Widget navBar() {
    return Container(
      child: Theme(
        data: ThemeData(canvasColor: Colors.blue),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Amigos')),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                title: Text('Mi lista'))
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.white),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
