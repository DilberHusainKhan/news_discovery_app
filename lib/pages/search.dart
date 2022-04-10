import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/newsmodel.dart';
import '../utils/section/leftsection.dart';
import '../utils/section/rightsection.dart';

class SearchNEWS extends StatefulWidget {
  const SearchNEWS({Key? key}) : super(key: key);

  @override
  State<SearchNEWS> createState() => _SearchNEWSState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _SearchNEWSState extends State<SearchNEWS> {
  final _debouncer = Debouncer();
  List<Newsmodel> newsList = [];
  List<Newsmodel> filterList = [];

  Future<List<Newsmodel>> getApi() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=b11505ab3291425f9067753110375041"));
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
  void initState() {
    super.initState();
    getApi().then((subjectFromServer) {
      setState(() {
        newsList = subjectFromServer;
        filterList = newsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          // padding: EdgeInsets.all(15),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: TextField(
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  suffixIcon: const InkWell(
                    child: Icon(Icons.search),
                  ),
                  contentPadding: const EdgeInsets.all(15.0),
                  hintText: 'Search ',
                ),
                onChanged: (string) {
                  _debouncer.run(() {
                    setState(() {
                      filterList = newsList
                          .where(
                            (u) => (u.title.toString().toLowerCase().contains(
                                  string.toLowerCase(),
                                )),
                          )
                          .toList();
                    });
                  });
                },
              ),
            ),
          ],
        ),
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
                      itemCount: filterList.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LeftSection(
                                  imgUrl:
                                      filterList[index].urlToImage.toString(),
                                  author: filterList[index].author.toString(),
                                  publisher:
                                      filterList[index].publishedAt.toString()),
                              const SizedBox(
                                width: 10,
                              ),
                              RightSection(
                                newsTitle: filterList[index].title.toString(),
                                newsDsc:
                                    filterList[index].description.toString(),
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
