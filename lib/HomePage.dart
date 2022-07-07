import 'package:dart_news/Models/HeadlinesResponse.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Network/api_client.dart';
import 'Styles/AppTheme.dart';

List<String> tags = [];
List<String> countries = [
  "ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb",
  "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl",
  "no", "nz", "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua",
  "us", "ve", "za"
];
String selectedCountry = "us";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String apiKey = "69098ca7575f42069325e5168a565e07";
  String country = "us";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  FutureBuilder<HeadlinesResponse> _getHeadlines(BuildContext context) {

    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<HeadlinesResponse>(

      future: client.getHeadlines(country, apiKey),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final HeadlinesResponse? posts = snapshot.data;
          return _buildHeadlineList(context, posts!);
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              // backgroundColor: Colors.white,
            ),
          );
        }
      },
    );
  }

  ListView _buildHeadlineList(BuildContext context, HeadlinesResponse posts) {
    List<Articles>? list = posts.articles;
    return ListView.builder(
      itemCount: posts.articles?.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {

          },
          child: Card(
            color: Colors.white,
            elevation: 8,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(list![index].title.toString(), style: AppTheme.titleText,),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 140,
                    child: Row(
                      children: [
                        FadeInImage.memoryNetwork(
                          image: list[index].urlToImage.toString(),
                          width: 130,
                          height: 130,
                          placeholder: kTransparentImage,
                          imageErrorBuilder:
                              (context, error, stackTrace) {
                            return Image.asset(
                                'assets/images/flag_placeholder.jpg',
                                width: 130,
                                height: 130,
                                fit: BoxFit.fitWidth);
                          },
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(child: Column(children: [
                          Expanded(child: Text(list[index].description.toString(), style: AppTheme.subtitleText,)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(children: [Expanded(child: Text("Read More..", style: AppTheme.readMoreText, textAlign: TextAlign.right,),)],)
                        ],))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownValue(){
    return Container(color: Colors.red, child: DropdownButton<String>(
      value: country,
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
      elevation: 0,
      style: AppTheme.countryPickerText,
      onChanged: (String? newValue) {
        setState(() {
          country = newValue!;
        });
      },
      items: countries
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(children: [
            Wrap(children: [Text(value.toUpperCase(), style: AppTheme.titleText,)],),
            SizedBox(width: 8,),
            FadeInImage.memoryNetwork(
              image: "https://countryflagsapi.com/png/$value",
              width: 40,
              height: 25,
              placeholder: kTransparentImage,
              imageErrorBuilder:
                  (context, error, stackTrace) {
                return Image.asset(
                    'assets/images/flag_placeholder.jpg',
                    width: 40,
                    height: 25,
                    fit: BoxFit.fitWidth);
              },
              fit: BoxFit.fitHeight,
            ),
            SizedBox(width: 16,),],),
        );
      }).toList(),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          // Row(children: [
          // Wrap(children: [Text(selectedCountry.toUpperCase())],),
          //   SizedBox(width: 8,),
          //   FadeInImage.memoryNetwork(
          //     image: "https://countryflagsapi.com/png/$country",
          //     width: 40,
          //     height: 25,
          //     placeholder: kTransparentImage,
          //     imageErrorBuilder:
          //         (context, error, stackTrace) {
          //       return Image.asset(
          //           'assets/images/flag_placeholder.jpg',
          //           width: 40,
          //           height: 25,
          //           fit: BoxFit.fitWidth);
          //     },
          //     fit: BoxFit.fitHeight,
          //   ),
          //   SizedBox(width: 16,),],),
          _buildDropdownValue()
          // IconButton(
          //   icon: const Icon(Icons.navigate_next),
          //   tooltip: 'Go to the next page',
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute<void>(
          //       builder: (BuildContext context) {
          //         return Scaffold(
          //           appBar: AppBar(
          //             title: const Text('Next page'),
          //           ),
          //           body: const Center(
          //             child: Text(
          //               'This is the next page',
          //               style: TextStyle(fontSize: 24),
          //             ),
          //           ),
          //         );
          //       },
          //     ));
          //   },
          // ),
        ],
      ),
      body: _getHeadlines(context),

      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('Dart News'),
            ),
            Card(elevation: 8, color: Colors.white, margin: EdgeInsets.all(8), child: Row(children: [SizedBox(width: 8), Icon(Icons.newspaper), Expanded(child: ListTile(
              title: const Text('All News'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ))],),),
            Card(elevation: 8, color: Colors.white, margin: EdgeInsets.all(8), child: Row(children: [SizedBox(width: 8), Icon(Icons.mic), Expanded(child: ListTile(
              title: const Text('All Sources'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ))],),),
            Card(elevation: 8, color: Colors.white, margin: EdgeInsets.all(8), child: Row(children: [SizedBox(width: 8), Icon(Icons.flag), Expanded(child: ListTile(
              title: const Text('All Sources'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ))],),),
            Card(elevation: 8, color: Colors.white, margin: EdgeInsets.all(8), child: Row(children: [SizedBox(width: 8), Icon(Icons.settings), Expanded(child: ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ))],),),
            Card(elevation: 8, color: Colors.white, margin: EdgeInsets.all(8), child: Row(children: [SizedBox(width: 8), Icon(Icons.logout), Expanded(child: ListTile(
              title: const Text('Log-Out'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ))],),),

          ],
        ),
      ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          icon: Icons.newspaper,
          backgroundColor: Colors.red,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.newspaper),
                label: "Business",
                onTap: () {

                  tags.clear();
                  tags.add("business");
                  // _buildRecipeBody(context);
                  ReloadWithTag("business");
                }
            ),
            SpeedDialChild(
                child: const Icon(Icons.newspaper),
                label: "Entertainment",
                onTap: () {
                  tags.clear();
                  tags.add("entertainment");
                  ReloadWithTag("entertainment");
                }
            ),
            SpeedDialChild(
                child: const Icon(Icons.newspaper),
                label: "General",
                onTap: () {
                  tags.clear();
                  tags.add("general");
                  // _buildRecipeBody(context);
                  ReloadWithTag("general");
                }
            ),
            SpeedDialChild(
                child: const Icon(Icons.newspaper),
                label: "Health",
                onTap: () {
                  tags.clear();
                  tags.add("health");
                  ReloadWithTag("health");
                }
            ),
            SpeedDialChild(
                child: const Icon(Icons.newspaper),
                label: "Science",
                onTap: () {
                  tags.clear();
                  tags.add("science");
                  ReloadWithTag("science");
                }
            ),
            SpeedDialChild(
                child: const Icon(Icons.newspaper),
                label: "Sports",
                onTap: () {
                  tags.clear();
                  tags.add("sports");
                  ReloadWithTag("sports");
                }
            ),
            SpeedDialChild(
                child: const Icon(Icons.newspaper),
                label: "Technology",
                onTap: () {
                  tags.clear();
                  tags.add("technology");
                  ReloadWithTag("technology");
                }
            ),
            SpeedDialChild(
                child: const Icon(Icons.newspaper),
                label: "All",
                onTap: () {
                  tags.clear();
                  tags.add("all");
                  ReloadWithTag("all");
                }
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void ReloadWithTag(String tag){

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const MyHomePage(title: "");
        },
      ),
    );
  }
}