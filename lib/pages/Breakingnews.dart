import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/newsmodel.dart';
import '../utils/section/leftsection.dart';
import '../utils/section/rightsection.dart';

class BreakingNEWS extends StatefulWidget {
  const BreakingNEWS({Key? key}) : super(key: key);

  @override
  State<BreakingNEWS> createState() => _BreakingNEWSState();
}

class _BreakingNEWSState extends State<BreakingNEWS> {
  List<Newsmodel> newsList = [];
  Future<List<Newsmodel>> getApi() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=b11505ab3291425f9067753110375041"));
    var data = jsonDecode(response.body.toString());
    // print(data['articles'][0]);
    // print(data);
    if (response.statusCode == 200) {
      newsList.clear();
      for (Map i in data['articles']) {
        // print(i);
        newsList.add(Newsmodel.fromJson(i));
      }
      return newsList;
    } else {
      return newsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: getApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      // shrinkWrap: true,
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LeftSection(
                                  imgUrl: newsList[index].urlToImage.toString(),
                                  author: newsList[index].author.toString(),
                                  publisher:
                                      newsList[index].publishedAt.toString()),
                              const SizedBox(
                                width: 10,
                              ),
                              RightSection(
                                newsTitle: newsList[index].title.toString(),
                                newsDsc: newsList[index].description.toString(),
                              ),

                              // (newsList[index].author.toString()),
                            ],
                          ),
                        ));
                      });
                }
              }),
        ),
      ],
    );
  }
}
