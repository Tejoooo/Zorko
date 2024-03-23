import 'package:flutter/material.dart';

class BottomNavgBar extends StatefulWidget {
  const BottomNavgBar({Key? key}) : super(key: key);

  @override
  State<BottomNavgBar> createState() => BottomNavgBarState();
}

class BottomNavgBarState extends State<BottomNavgBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66, // Adjust the height according to your design
      padding: const EdgeInsets.all(9),
    margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 22),
      decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24)),

        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
            onPressed: () => _onItemTapped(0),
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: _selectedIndex == 1 ? Colors.blue : Colors.grey),
            onPressed: () => _onItemTapped(1),
          ),
          IconButton(
            icon: Icon(Icons.grid_on, color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
            onPressed: () => _onItemTapped(2),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: _selectedIndex == 3 ? Colors.blue : Colors.grey),
            onPressed: () => _onItemTapped(3),
          ),
          IconButton(
            icon: Icon(Icons.person, color: _selectedIndex == 4 ? Colors.blue : Colors.grey),
            onPressed: () => _onItemTapped(4),
          ),
        ],
      ),
    );
  }
}