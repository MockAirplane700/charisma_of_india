// this class holds the application's order history

import 'package:charisma_of_india/customObjects/menu.dart';

class OrderHistory {
  // a list that holds the order history
  static List<Menu> _orderHistory = [];

  // return the listing of the order history as a list of menu objects
  static List<Menu> getOrderHistory() {
    return _orderHistory;
  }

  //add to the list of menu objects that is the history of purchase
  static void addToHistory(Menu menu) {
    _orderHistory.add(menu);
  }

  //add a new item to the order history
  static void setNewOrderHistory(List<Menu> value){
    _orderHistory = value;
  }
}