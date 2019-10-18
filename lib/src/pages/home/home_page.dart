import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:good_start/src/pages/authentication/authentication_page.dart';
import 'package:good_start/src/pages/modules/modules_page.dart';
import 'package:good_start/src/shared/styles/style.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(title: Text("Logout"),onTap: (){
                // Navigator.replaceRouteBelow(context,anchorRoute: MaterialPageRoute(builder: (context)=>HomePage()),newRoute: MaterialPageRoute(builder: (context)=>AuthenticationPage()));
              },)
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 75),
          child: CustomAppBar(),
        ),
        backgroundColor: Color(0xffFFFAFA),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(
                icon: Icon(
              Icons.book,
              color: Colors.red,
            )),
            Tab(
                icon: Icon(
              Icons.person_outline,
              color: Colors.red,
            ))
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              // height: MediaQuery.of(context).size.height,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[HomePageWidget(), ModulesPage()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:
          const EdgeInsets.only(left: 20.0, right: 20),
      decoration: BoxDecoration(color: Color(0xffFFFAFA), boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(150, 15, 15, 0.05),
            spreadRadius: 10,
            blurRadius: 5)
      ]),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("goodstart ",
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Image.asset("lib/assets/images/apple-emoji.png",height:20),
                  SizedBox(width: 3),
                  Image.asset("lib/assets/images/clapping-hands-emoji.png",height:20),
                  SizedBox(width: 3),
                  Image.asset("lib/assets/images/books-emoji.png",height:20)
                  ],
                ),
                Text(
                  "módulos",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 5,)
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Material( //for some reason only material is printing it square
                child: IconButton(
                  icon: Icon(Icons.menu, size: 30),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Basics of english",
                          softWrap: true,
                          style: moduleWidgetTitle,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "13 exercises, 2 videos",
                          style: moduleWidgetSubtitle,
                        )
                      ],
                    )),
                Expanded(
                    child:
                        Icon(Icons.portrait, size: 100, color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
