// this class returns a fake listing of the menu items

import 'package:charisma_of_india/customObjects/menu.dart';

class MenuListing {
  static List<Menu> getMenuItems() {
    return <Menu>[
      Menu(
        networkImage: 'https://charismaofindia.ca/wp-content/uploads/2020/12/Butter_Chicken_3_FM.jpg',
        dishName: 'Some dish',
        price: 90,
        dishDescription: 'Boneless pieces of baked tandoor chicken, blended with exotic spices',
        specialInstructions: 'lorem ipsum',
      ),
      Menu(
        networkImage: 'https://charismaofindia.ca/wp-content/uploads/2020/12/Butter_Chicken_3_FM.jpg',
        dishName: 'Some dish',
        price: 90,
        dishDescription: 'Boneless pieces of baked tandoor chicken, blended with exotic spices',
        specialInstructions: 'lorem ipsum',
      ),
      Menu(
        networkImage: 'https://charismaofindia.ca/wp-content/uploads/2020/12/Butter_Chicken_3_FM.jpg',
        dishName: 'Some dish',
        price: 90,
        dishDescription: 'Boneless pieces of baked tandoor chicken, blended with exotic spices',
        specialInstructions: 'lorem ipsum',
      ),
    ];
  }
}