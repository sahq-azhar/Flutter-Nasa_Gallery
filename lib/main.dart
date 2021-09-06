import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_project_name/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_project_name/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Googlesans',
      ),
      title: 'Nasa Gallery',
      home: SplashScreen(),
    );
  }
}

class Test extends StatelessWidget {
  Future<List> fetchAds() async {
    //the link you want to data from, goes inside get
    var url = Uri.parse(
        "https://raw.githubusercontent.com/sahq-azhar/Flutter-Nasa_Gallery/main/data.json");
    final response = await http.get(url);
    if (response.statusCode == 200) return json.decode(response.body);
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 145),
          child: FutureBuilder<List>(
              future: fetchAds(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return new Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: new StaggeredGridView.count(
                      crossAxisCount: 4, //  two card horizontally
                      padding: const EdgeInsets.all(2.0),
                      children: snapshot.data.map<Widget>((item) {
                        return new MyHomePage(item);
                      }).toList(),

                      //Here is the place that we are getting flexible/ dynamic card for various images
                      staggeredTiles: snapshot.data
                          .map<StaggeredTile>((_) => StaggeredTile.fit(2))
                          .toList(),
                      mainAxisSpacing: 3.0,
                      crossAxisSpacing: 4.0,
                    ),
                  );
                } else {
                  return Center(child: new CircularProgressIndicator());
                }
              }),
        ),
        Container(
          height: 150,
          child: Center(
            child: Text(
              'Nasa Gallery',
              style: TextStyle(color: Colors.white, fontSize: 28.0),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/space.gif"), fit: BoxFit.cover),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
      ],
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.ad);
  final ad;
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //to keep things readable
  var pf;
  String image;
  String title;
  String own;
  String date;

  void initState() {
    setState(() {
      pf = widget.ad;
      //if values are not null only we need to show them
      image = (pf['url'] != '') ? pf['url'] : '';
      title = (pf['title'] != '') ? pf['title'] : '';
      own = (pf['copyright'] != '') ? pf['copyright'] : '';
      date = (pf['date'] != '') ? pf['date'] : '';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        semanticContainer: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Detailpage(pf)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),

              //Image.network(image),
              Text(
                title,
                style: new TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                own == null ? 'Not available' : '\© $own',
              ),
              Text(date),
            ],
          ),
        ));
  }
}
