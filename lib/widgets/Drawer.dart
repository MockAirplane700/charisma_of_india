// the navigation drawer for the application

import 'package:charisma_of_india/customObjects/about.dart';
import 'package:charisma_of_india/customObjects/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final  About about = About(
      name: 'Charisma of India mobile application',
      networkImage: 'https://charismaofindia.ca/wp-content/uploads/2020/11/cropped-4-COI-132x76.png',
      description: 'Charisma of India is an elegant Indian restaurant in Wolseley, on Sherbrook Street featuring a full menu of authentic Northern Indian cuisine. Catering Available for Large or Small Parties starting at \$19.99 per person or Full Service Catering starting at \$29.99 per person at your location or ours. Fully Licensed Dining Room. 130 People capacity " We are thankful to all of our loyal customers for supporting us in these difficult and trying times, we owe our success to you and hope that you all stay safe and keep supporting us. Stay strong Winnipeg, stay strong Canada and remember to buy local and support local, because when you buy local it helps support businesses and families " - Mitesh Trivedi, Owner ',
      website: 'https://charismaofindia.ca/',
      phone: '204-228-7878',
      email: 'hmtrivedi@hotmail.com',
      address: 'Wosleley on Sherbrook Street'
  );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: primaryDrawerColor),
              child: CircleAvatar(child: Icon(Icons.person, size: MediaQuery.of(context).size.width/5,),)
          ),
          ListTile(
            title: const Text('Contact help'),
            onTap: () {
              //todo: use url_launcher to call help line or text it natively
              Navigator.pop(context,'');
            },
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              //go to about page or show dialog box
              Navigator.pop(context,'');
              showDialog(
                  context: context,
                  builder: (BuildContext context)=> AlertDialog(
                    title: const Text('Alert dialog'),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(about.networkImage),
                          Text('Name: ' + about.name , ),
                          Text(about.description, maxLines: 25,),
                          Text(about.address),
                          const Text('Contact Us', style: TextStyle(fontSize: 15),),
                          Text(about.email),
                          Text(about.phone),
                          Text(about.website)

                        ],
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text('Cancel')),
                      TextButton(onPressed: ()=> Navigator.pop(context,'OK'), child: const Text('OK'))
                    ],
                  )
              );
            },
          )
        ],
      ),
    );
  }
}
