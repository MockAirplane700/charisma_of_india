// holds the about object information from the data base in case the store changes something

class About {
  final String name;
  final String description;
  final String address;
  final String email;
  final String phone;
  final String website;
  final String networkImage;

  About({required this.name,
    required this.networkImage, required this.description,
    required this.website, required this.phone, required this.email, required this.address});
}