import 'package:clubnorms/screens/homescreen/createGroups/CreateGroups.dart';
import 'package:clubnorms/screens/homescreen/groups/Groups.dart';
import 'package:clubnorms/screens/homescreen/profile/Profile.dart';
import 'package:flutter/material.dart';

class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({super.key});

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  int _selectedIndex = 0;  

   void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  

    static const List<Widget> _widgetOptions = <Widget>[  
    const Groups(),
    const Creategroups(),
    const Profile(),  
  ];  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.group),
        label: 'Groups',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: 'Add Group',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black38,
        onTap: _onItemTapped,  
        elevation: 2  
  ),
  body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),);
  }
}