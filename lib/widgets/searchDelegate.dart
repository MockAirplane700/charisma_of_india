// Here we have the search delegate
import 'package:charisma_of_india/customObjects/constants.dart';
import 'package:charisma_of_india/customObjects/menu.dart';
import 'package:charisma_of_india/logic/cart.dart';
import 'package:charisma_of_india/logic/menu_listing.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate{
  // list of search results or data to be searched
  List<Menu> searchResults = MenuListing.getMenuItems();
  int count =1;
  int indexValue = 0;

  String geDishNameFromMenu(String item) {
    for (int value = 0; searchResults.length < value; value++){
      if (searchResults[value].dishName.toLowerCase() == (item.toLowerCase())) {
        indexValue = value;
        return searchResults[value].dishName;
      }else{
        return "Dish name not found";
      }
    }
    return "Exited for loop, list empty ";
  }

  String geDishNetImageFromMenu(String item) {
    for (int value = 0; searchResults.length < value; value++){
      if (searchResults[value].networkImage.toLowerCase() == (item.toLowerCase())) {
        return searchResults[value].networkImage;
      }else{
        return "Network image not found";
      }
    }
    return "Loop exited list must be empty";
  }

  String geDishDescriptFromMenu(String item) {
    for (int value = 0; searchResults.length < value; value++){
      if (searchResults[value].dishDescription.toLowerCase() == (item.toLowerCase())) {
        return searchResults[value].dishDescription;
      }else{
        return "Dish description value is not found";
      }
    }
    return "Loop exited list must be empty";
  }

  String geDishPriceFromMenu(String item) {
    for (int value = 0; searchResults.length < value; value++){
      if (searchResults[value].price.toString().toLowerCase() == (item.toLowerCase())) {
        return searchResults[value].price.toString();
      }else{
        return "Price match not found ";
      }
    }
    return "Loop exited List must be empty";
  }

  String geDishAmountMenu(String item) {
    for (int value = 0; searchResults.length < value; value++){
      if (searchResults[value].amount.toString().toLowerCase() == (item.toLowerCase())) {
        return searchResults[value].amount.toString();
      }else{
        return "Amount was not found";
      }
    }
    return "Loop exited, list must be empty";
  }

  String geDishSpecialInstructionsMenu(String item) {
    for (int value = 0; searchResults.length < value; value++) {
      if (searchResults[value].specialInstructions.toLowerCase() ==
          (item.toLowerCase())) {
        return searchResults[value].specialInstructions;
      } else {
        return "Special instructions not found list must be empty";
      }
    }
    return "Loop exited, list must be empty";
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        onPressed: () {query = '';},
        icon: const Icon(Icons.clear)
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
  );

  @override
  Widget buildResults(BuildContext context) => Center(
    child: Card(
      color: primaryCardColor,
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(geDishNetImageFromMenu(query)),
          Text(geDishAmountMenu(query)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    //decrease the count by 1
                    count -=1;
                    searchResults[indexValue].set_amount(count);

                  },
                  icon: const Icon(Icons.remove)
              ),
              Text(count.toString()),
              IconButton(
                  onPressed: () {
                    //increment the count
                    count+=1;
                    searchResults[indexValue].set_amount(count);
                  },
                  icon: const Icon(Icons.add)
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment:  CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    //display the generic snack bar
                    //add the product to the cart listing
                    Cart.addToCart(searchResults[indexValue]);
                  },
                  child: const Text('add to cart')
              )
            ],
          ),
          TextField(
            autofocus: false,
            decoration: const InputDecoration.collapsed(hintText: 'Special instructions'),
            onChanged: (String value) {
              //set the special instructions
              searchResults[indexValue].set_special_instructions(value);
            },
          )
        ],
      ),
    ),
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<Menu> suggestions = searchResults.where((searchResult) {
      final result = searchResult.dishName.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Card(
              color: primaryCardColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(suggestions[index].networkImage),
                  Text(suggestions[index].dishDescription),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            //increment the count
                            count -=1;
                            suggestions[index].set_amount(count);
                          },
                          icon: const Icon(Icons.remove)
                      ),
                      Text(count.toString()),
                      IconButton(
                          onPressed: () {
                            //increment the count
                            count +=1;
                            suggestions[index].set_amount(count);
                          },
                          icon: const Icon(Icons.add)
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            //add the product to the cart
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
                            Cart.addToCart(suggestions[index]);
                          },
                          child: const Text('add to cart')
                      )
                    ],
                  ),
                  TextField(
                    autofocus: false,
                    onChanged: (String value) {
                      suggestions[index].set_special_instructions(value);
                    },
                    decoration: const InputDecoration.collapsed(hintText: 'Special instructions'),
                  )
                ],
              ),
            ),
            onTap: () {
              query = suggestions[index].dishName;
              showResults(context);
            },
          );
        },
      itemCount: suggestions.length,
    );
  }

}