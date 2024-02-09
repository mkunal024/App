import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width:150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width:2.0,),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Additional Links'),
          LinkItem(
            text: 'Google',
            url: 'https://www.google.com',
          ),
          LinkItem(
            text: 'Flutter',
            url: 'https://flutter.dev/docs',
          ),
          // Add more LinkItems as needed
        ],
      ),
    );
  }
}

class LinkItem extends StatelessWidget {
  final String text;
  final String url;

  const LinkItem({
    Key? key,
    required this.text,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Open the link when tapped
          // You can customize this behavior based on your needs
          launch(url);
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
