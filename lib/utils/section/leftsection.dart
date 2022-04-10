import 'dart:math';

import 'package:flutter/material.dart';

class LeftSection extends StatelessWidget {
  final String imgUrl, author, publisher;
  const LeftSection(
      {Key? key,
      required this.imgUrl,
      required this.author,
      required this.publisher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 100, //minimum height
              minWidth: 50, // minimum width

              maxHeight: MediaQuery.of(context).size.height,
              //maximum height set to 100% of vertical height

              maxWidth: MediaQuery.of(context).size.width,
              //maximum width set to 100% of width
            ),
            child: imgUrl == "null"
                ? const Icon(Icons.image_not_supported_outlined)
                : Image.network(imgUrl),
          ),
          Text(author == "null" ? "unknown author" : author),
          const SizedBox(
            height: 20,
          ),
          Text(publisher)
        ],
      ),
    );
  }
}
