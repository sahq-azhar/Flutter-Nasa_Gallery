import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detailpage extends StatefulWidget {
  Detailpage(this.pf, this.sd);
  final pf;
  final sd;
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  var pf;
  var sd;
  String image;
  String title;
  String own;
  String date;
  String detail;

  void initState() {
    setState(() {
      pf = widget.pf;
      sd = widget.sd;
      image = (pf['url'] != '') ? pf['url'] : '';
      title = (pf['title'] != '') ? pf['title'] : '';
      own = (pf['copyright'] != '') ? pf['copyright'] : '';
      date = (pf['date'] != '') ? pf['date'] : '';
      detail = (pf['explanation'] != '') ? pf['explanation'] : '';
    });

    super.initState();
  }

  /*    final Info info;
  Detailpage(this.info, {jsonData});  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GestureDetector(
          onPanUpdate: (dis) {
            if (dis.delta.dx < 0) {
              print("right");
              setState(() {
                title = sd[sd.indexOf(pf) + 1]['title'];
                image = sd[sd.indexOf(pf) + 1]['url'];
                own = sd[sd.indexOf(pf) + 1]['copyright'];
                date = sd[sd.indexOf(pf) + 1]['date'];
                detail = sd[sd.indexOf(pf) + 1]['explanation'];
                pf = sd[sd.indexOf(pf) + 1];
              });
            } else if (dis.delta.dx > 0) {
              print("left");
              setState(() {
                title = sd[sd.indexOf(pf) - 1]['title'];
                image = sd[sd.indexOf(pf) - 1]['url'];
                own = sd[sd.indexOf(pf) - 1]['copyright'];
                date = sd[sd.indexOf(pf) - 1]['date'];
                detail = sd[sd.indexOf(pf) - 1]['explanation'];
                pf = sd[sd.indexOf(pf) - 1];
              });
            }
          },
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: FittedBox(
                  child: Image.network(image),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        own == null ? 'Not available' : '\© $own',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "icon/cal.ico",
                          width: 19,
                        ),
                        Text(
                          date == null ? 'Not available' : date,
                          style: new TextStyle(
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(color: Colors.black),
              ),
              Center(
                child: Text(
                  "Detail",
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Text(
                    detail,
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




     /*       Container(
            width: double.infinity,
            height: 400.0,
            
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(image)),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
          ), */
          /*   FittedBox(
            child: Image.network(image),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ) */


      