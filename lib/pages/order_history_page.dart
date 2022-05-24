//here we have a simple listing of the user's order history

import 'package:charisma_of_india/customObjects/constants.dart';
import 'package:charisma_of_india/customObjects/menu.dart';
import 'package:charisma_of_india/logic/OrderHistory.dart';
import 'package:charisma_of_india/logic/cart.dart';
import 'package:charisma_of_india/widgets/Drawer.dart';
import 'package:charisma_of_india/widgets/NavBar.dart';
import 'package:charisma_of_india/widgets/searchDelegate.dart';
import 'package:flutter/material.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final List<Menu> _list = OrderHistory.getOrderHistory();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order history'),
        backgroundColor: primaryAppBarColor,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search)
          )
        ],
      ),
      backgroundColor: primaryBackgroundColor,
      body: Center(
        child: ListView.builder(
            itemBuilder: (context, index) {
              if (_list.isEmpty){
                //no order history present
                return const Center(child: Text('ORDER HISTORY IS EMPTY'),);
              }else{
                //order history present
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Expanded(child: Text('Name ')),
                          Expanded(child: Text(_list[index].dishName))
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(child: Text('Quantity ')),
                          Expanded(child: Text(_list[index].amount.toString()))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // add the listed item to the cart
                                Cart.addToCart(_list[index]);
                              },
                              child: const Text('Reorder')
                          )
                        ],
                      )
                    ],
                  ),
                  color: primaryCardColor,
                );
              }
            },
          itemCount: _list.length,
        ),
      ),
      drawer: const CustomDrawer(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
