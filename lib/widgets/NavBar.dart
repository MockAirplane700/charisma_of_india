// the bottom navigation bar

import 'package:charisma_of_india/pages/checkout_page.dart';
import 'package:charisma_of_india/pages/menu_page.dart';
import 'package:charisma_of_india/pages/order_history_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  const BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = widget.selectedIndex;
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Order history'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart')
        ],
      currentIndex: _selectedIndex,
      onTap: (int index) {
          setState(() {
            _selectedIndex = index;

            if (index == 0) {
              //go to order history
              Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> const OrderHistoryPage())
              );
            }else if (index ==1) {
              //go to menu
              Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> const MenuHome())
              );
            }else{
              //go to the cart
              Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> const Checkout())
              );
            }
          });
      },
    );
  }
}
