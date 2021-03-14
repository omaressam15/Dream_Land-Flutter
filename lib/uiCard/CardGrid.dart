import 'package:dream_land/Ui/CenterStar.dart';
import 'package:flutter/material.dart';

class CardGrid extends StatefulWidget {
  String image;

  String title;

  CardGrid({this.image, this.title});

  @override
  _CardGridState createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  @override
  Widget build(BuildContext context) {


    return Material(

      elevation: 2,

      shadowColor: Colors.grey[350],

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),),


        child: InkWell(


            child: Container(

              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(

                children: [

                  Align(

                    child: Image.network("${widget.image}",fit: BoxFit.cover,width: 130,height: 130,
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "${widget.title}",style: TextStyle(fontSize: 15,
                        color: Colors.black,
                        height: 1.6,
                        fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,

                    ),
                  ),
                ],
              ),
            ),
          ),

    );

  }
}
