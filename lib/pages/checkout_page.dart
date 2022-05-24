// the checkout page, here is where they purchase the food
import 'package:charisma_of_india/customObjects/constants.dart';
import 'package:charisma_of_india/customObjects/menu.dart';
import 'package:charisma_of_india/logic/OrderHistory.dart';
import 'package:charisma_of_india/logic/cart.dart';
import 'package:charisma_of_india/widgets/Drawer.dart';
import 'package:charisma_of_india/widgets/NavBar.dart';
import 'package:charisma_of_india/widgets/searchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final List<Menu> _list = Cart.getCart();
  int deliveryFee = 10;
  String email = '';

  void _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) throw 'Could not launch $Exception' ;
  }

  @override
  Widget build(BuildContext context) {
    //check if the cart is empty or not
    return Scaffold(
      appBar: AppBar(
        title: const Text('cart'),
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
      body:Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/2,
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // the image of the dish on the card
                            Flexible(fit: FlexFit.loose,child: Image.network(_list[index].networkImage)),
                            SizedBox(width: MediaQuery.of(context).size.width/40,),
                            Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(_list[index].dishName),
                                    Text('Price: \$' + _list[index].price.toString() ),
                                    Text('Quantity: ' + _list[index].amount.toString())

                                  ],
                                ) ,
                              fit: FlexFit.loose,
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width/10,),
                            Flexible(
                                child: IconButton(
                                onPressed: () {
                                  //todo display dialog box to display new amount
                                },
                                icon:const  Icon(Icons.edit)
                            ),
                              fit: FlexFit.loose,
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width/10,),
                            Flexible(
                                child: IconButton(
                                    onPressed: () {
                                      //delete the entry from the cart
                                      setState(() {
                                        Cart.removeFromCart(index);
                                      });
                                    },
                                    icon: const Icon(Icons.delete)
                                ),
                              fit: FlexFit.loose,
                            )
                          ],
                        ),
                        color: primaryCardColor,
                      );
                    },
                  itemCount: _list.length,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Flexible(child: Text('Base'), fit: FlexFit.loose,),
                            Flexible(child: Text('    \$' + Cart.getTotal().toString()), fit: FlexFit.loose,),

                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Flexible(child: Text('Taxes'), fit: FlexFit.loose,),
                            Flexible(child: Text('    \$' + Cart.getTaxes().toStringAsFixed(2)), fit: FlexFit.loose,)
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Flexible(child: Text('Delivery fee'), fit: FlexFit.loose,),
                            Flexible(child: Text('    \$10.99'))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Flexible(child: Text('Total'), fit: FlexFit.loose,),
                            Flexible(child: Text('    \$' + Cart.getTotalAmount(Cart.getTotal(),Cart.getTaxes() , deliveryFee.toDouble()).toStringAsFixed(2), style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),),
                              fit: FlexFit.loose,
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              // display snack bar to show to user this is a demo
                              ScaffoldMessenger.of(context).showSnackBar(genericSnackBar);
                              //set the order history listing as soon as the order is placed
                              List<Menu> _newList = Cart.getCart();
                              OrderHistory.setNewOrderHistory(_newList);
                              // display dialog box letting the user know of the state
                              //todo: in dialog box for demo only take email to send confirmation order to
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context)=> AlertDialog(
                                    title: const Text('Charisma of India'),
                                    // here is where we want to take the user email
                                    content: TextField(
                                      onChanged: (String value) {
                                        setState(() {
                                          email = value;
                                          // send a confirmation email to the given address
                                        });
                                        //todo: let the user know the order has been placed
                                      },
                                      decoration:const  InputDecoration.collapsed(hintText: 'Enter email to send confirmation to'),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: ()=> Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel')
                                      ),
                                      TextButton(
                                          onPressed: (){
                                            _launchUrl(Uri(
                                                scheme: 'mailto',
                                                path: email + '?subject=Order Confirmation&body=This is a test, the order has been confirmed%20plugin'
                                            ));
                                            Navigator.pop(context,'OK');
                                          },
                                          child: const Text('OK')
                                      )
                                    ],
                                  )
                              );
                            },
                            child: const Text('Pay now')
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ) ,
      drawer: const CustomDrawer(),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}
