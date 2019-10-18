import 'package:flutter/material.dart';
import 'package:good_start/src/pages/modules/UncenteredPageScrollPhysics.dart';
import 'package:good_start/src/shared/styles/style.dart';

class ModulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          padding: EdgeInsets.only(left: 12),
          physics: UncenteredPageScrollPhysics(
              itemExtent: MediaQuery.of(context).size.width * 0.85 + 16),
          itemBuilder: (context, i) {
            return SingleChildScrollView(
                child: ModuleWidget(title: "INICIANTE"));
          },
        ),
      ),
    ]);
  }
}

class ModuleWidget extends StatelessWidget {
  const ModuleWidget({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.all(13),
          color: Color(0xffFFC9C9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 24, fontFamily: "Roboto"),
                ),
              ),
              SizedBox(height: 10),
              LessonWidget(
                title: "To Be",
              ),
              SizedBox(height: 20),
              LessonWidget(title: "Animais"),
              SizedBox(height: 20),
              LessonWidget(
                title: "Lugares",
              ),
              SizedBox(height: 20),
              LessonWidget(
                title: "Conversação",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LessonWidget extends StatelessWidget {
  const LessonWidget({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("lib/assets/images/headphone-emoji.png",
                          width: 30),                      SizedBox(
                        width: 10,
                      ),
                      Text(title,style: TextStyle(color: Colors.black87,fontSize: 17,fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset("lib/assets/images/headphone-emoji.png",
                          width: 30),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Image.asset("lib/assets/images/writing-hand-emoji.png",
                        width: 40),
                    SizedBox(width: 10),
                    Text("5 exercícios")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Image.asset("lib/assets/images/movie-emoji.png", width: 40),
                    SizedBox(width: 10),
                    Text("2 vídeos")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
