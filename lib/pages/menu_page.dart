// a listing of the menu items on offer
import 'package:charisma_of_india/customObjects/constants.dart';
import 'package:charisma_of_india/customObjects/menu.dart';
import 'package:charisma_of_india/logic/cart.dart';
import 'package:charisma_of_india/logic/menu_listing.dart';
import 'package:charisma_of_india/widgets/Drawer.dart';
import 'package:charisma_of_india/widgets/NavBar.dart';
import 'package:charisma_of_india/widgets/searchDelegate.dart';
import 'package:flutter/material.dart';

class MenuHome extends StatefulWidget {
  const MenuHome({Key? key}) : super(key: key);

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  int count = 1;
  final List<Menu> _list = MenuListing.getMenuItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
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
              //check if the list is empty
              if(_list.isEmpty) {
                //list is empty
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Please wait while we fetch the relevent data')
                    ],
                  ),
                );
              }else{
                //list is not empty
                return Card(
                  color: primaryCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(_list[index].networkImage),
                      Text(_list[index].dishName),
                      Text(_list[index].dishDescription),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  //decrease count by 1
                                  count -=1;
                                });
                              },
                              icon: const Icon(Icons.remove)
                          ),
                          Text(count.toString()),
                          IconButton(
                              onPressed: () {
                                //increment the count by 1
                                setState(() {
                                  count+=1;
                                });
                              },
                              icon: const Icon(Icons.add)
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                //set the number of menu items ordered
                                _list[index].set_amount(count.toDouble());
                                //add the item to the cart list
                                Cart.addToCart(_list[index]);
                              },
                              child: const Text('add to cart')
                          ),
                        ],
                      ),
                      TextField(
                        autofocus: false,
                        decoration: const InputDecoration.collapsed(hintText: 'Special Instructions'),
                        onChanged: (String value) {
                          setState(() {
                            //add the special instructions to the relevant object
                            _list[index].set_special_instructions(value);
                          });
                        },
                      )
                    ],
                  ),
                );
              }//end if-else
            },
          itemCount: _list.length,
        ),
      ),
      drawer: const CustomDrawer(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }
}
