import 'package:flutter/material.dart';

class RightSection extends StatelessWidget {
  final String newsTitle, newsDsc;
  const RightSection({Key? key, required this.newsTitle, required this.newsDsc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            newsTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.visible,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(newsDsc, maxLines: 4, overflow: TextOverflow.visible)
        ],
      ),
    );
  }
}
