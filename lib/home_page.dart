import 'package:flutter/material.dart';
import 'dart:convert';
import 'models/country_names.dart';
import 'package:http/http.dart' as http;
import 'news_grid.dart';
import 'news_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

String data;
String country = _countries[0].short;
List<CountryNames> _countries = [
  CountryNames(
    short: 'ae',
    full: 'United Arab Emirates',
  ),
  CountryNames(
    short: 'ar',
    full: 'Argentina',
  ),
  CountryNames(
    short: 'at',
    full: 'Austria',
  ),
  CountryNames(
    short: 'au',
    full: 'Australia',
  ),
];

class _HomePageState extends State<HomePage> {
  Future<void> getNews() async {
    http.Response response = await http.get(
        'https://newsapi.org/v2/top-headlines?country=$country&apiKey=48a3f8a4729349309eb96d25c6ecc431');
    if (response.statusCode == 200) {
      setState(() {
        data = response.body;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Top Headlines',
          style: TextStyle(color: Colors.lightBlueAccent),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Container(
                  height: 70,
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 10),
                    itemCount: _countries.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            country = _countries[index].short;
                            getNews();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: 10,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueGrey,
                          ),
                          child: Center(
                              child: Text(
                            _countries[index].full,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          )),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        return NewsGrid(
                          title: jsonDecode(data)['articles'][index]['title'],
                          imagePath: jsonDecode(data)['articles'][index]
                              ['urlToImage'],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsPage(
                                        newsUrl: jsonDecode(data)['articles']
                                            [index]['url'],
                                      )),
                            );
                          },
                        );
                      },
                      itemCount: jsonDecode(data)['articles'].length > 20
                          ? 20
                          : jsonDecode(data)['articles'].length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
