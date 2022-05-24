// Menu object holds the menu items that are to be listed!
class Menu {
  final String dishName;
  final String dishDescription;
  final String networkImage;
  String specialInstructions;
  final double price;
  int amount= 1;

  Menu({
    required this.networkImage, required this.dishName, required this.price,
    required this.dishDescription, required this.specialInstructions
});

  void set_amount(double count){
    amount = count.toInt();
  }

  int  get_amount() {return amount;}

  void set_special_instructions(String instructions) {
    specialInstructions = instructions;
  }

}