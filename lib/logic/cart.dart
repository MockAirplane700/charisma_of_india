// this is where we will hold a list of the cart items

import 'package:charisma_of_india/customObjects/menu.dart';

class Cart {
  static  List<Menu> _cart = [];
  static int calculatedTotal = 0;

  //add items to the cart
  static void addToCart(Menu menu) {
    _cart.add(menu);
  }//end method

  // return the listing of menu items in the cart
  static List<Menu> getCart() {
    return _cart;
  }

  //remove one item from the cart completely
  static void removeFromCart(int index) {
    _cart.removeAt(index);
  }

  // get the total cost of all menu object items in the list
  static int getTotal() {
    double total = 0;
    for (int k =0; k< _cart.length; k++) {
      total += _cart[k].price;
    }
    return total.toInt();
  }

  // get the taxes calculation based of the menu items in the cart list
  static int getTaxes(){
    double total = 0;
    for (int k =0; k< _cart.length; k++) {
      total += _cart[k].price;
    }
    double result = 0.13 * total;
    return result.toInt();
  }

  // gets the total between the taxes and any other service charges
  static int getTotalAmount(int total, int taxes, int delivery){
    calculatedTotal = total + taxes + delivery;
    return calculatedTotal;
  }
}