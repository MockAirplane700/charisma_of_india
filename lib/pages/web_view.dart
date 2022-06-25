import 'dart:io';

import 'package:charisma_of_india/customObjects/constants.dart';
import 'package:charisma_of_india/widgets/Drawer.dart';
import 'package:charisma_of_india/widgets/searchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web_view extends StatefulWidget {
  const Web_view({Key? key}) : super(key: key);

  @override
  State<Web_view> createState() => _Web_viewState();
}

class _Web_viewState extends State<Web_view> {
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charisma of Inida', style: TextStyle(color: primaryTextColor),),
        backgroundColor: primaryAppBarColor,
        iconTheme: const IconThemeData(color: primaryTextColor),
      ),
      backgroundColor: primaryBackgroundColor,
      body: Center(
        child: WebView(
          key: _key,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://charismaofindia.ca/",
        ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}


