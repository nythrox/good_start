import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
                         Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://imgs.clipartwiki.com/clipimg/small/215-2154246_leaf-of-apple-clipart-worm-inside-free-clip.png")
                        )
                    )),
          FlatButton(
            color: Colors.transparent,
            onPressed: (){},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text("SignUp"),
          ),
          FlatButton(
            color: Colors.white,
            onPressed: (){},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Text(
              "LogIn",
              style: TextStyle(color: Theme.of(context).primaryColor)),
          )
        ],
      ),
    );
  }
}