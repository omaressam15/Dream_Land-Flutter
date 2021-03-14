import 'package:dream_land/Model/ModelDreamLand.dart';
import 'package:dream_land/Model/ModelPhotos.dart';
import 'package:dream_land/uiCard/CardForImages.dart';
import 'package:dream_land/uiCard/CardGrid.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'CenterAlBahga.dart';
import 'CenterFlag.dart';
import 'CenterStar.dart';
import 'ServicesDreamLand.dart';

class HomeDream extends StatefulWidget {
  @override
  _HomeDreamState createState() => _HomeDreamState();
}

class _HomeDreamState extends State<HomeDream> {

  bool isLoading = true;

  List<ModelDream> modelDream = [];

  List <ModelPhoto> modelPhoto = [];


 Future <void> setPhotoFireBase() async {
    DatabaseReference reference =
    FirebaseDatabase.instance.reference().child('DreamLand').child('images');

   await reference.once().then((DataSnapshot snapshot) {
      modelPhoto.clear();

      var keys = snapshot.value.keys;

      var values = snapshot.value;

      for (var keys in keys) {
        ModelPhoto dream = new ModelPhoto(

          values[keys]['image'],
          values[keys]["images"],
        );
        modelPhoto.add(dream);
      }

      isLoading = false;
      setState((){});
    });

  }

 Future <void> setGridFireBase() async {
    DatabaseReference reference =
    FirebaseDatabase.instance.reference().child('DreamLand').child('Dream');

    await reference.once().then((DataSnapshot snapshot) {
      modelDream.clear();

      var keys = snapshot.value.keys;

      var values = snapshot.value;

      for (var keys in keys) {
        ModelDream dream = new ModelDream(
          values[keys]['image'],
          values[keys]["name"],
        );
        modelDream.add(dream);
      }
      isLoading = false;
      setState(() {});
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setGridFireBase();
    setPhotoFireBase();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
        child: LoadingBouncingGrid.circle(
          size: 50,
          borderColor: Colors.white,
          backgroundColor: Colors.cyan,

        ),
      ):

      Column(
        children: [

          ListView.builder(

              shrinkWrap: true,

              itemCount: modelPhoto.length,

              physics: NeverScrollableScrollPhysics(),

              itemBuilder:(context,index){
                return CardImages(

                  image:modelPhoto[index].image,

                  images:modelPhoto[index].images ,


                );
              }
          ),

          Padding(padding: EdgeInsets.only(bottom: 47)),



          Expanded(

            child: RefreshIndicator(

              onRefresh: () {
                setPhotoFireBase();
                setGridFireBase();
                return setGridFireBase();

              },

              child: GridView.builder(

                  itemCount: modelDream.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  itemBuilder: (context, index) {

                    return InkWell(

                      onTap: (){

                        setState(() {

                          if(0 == index){

                            Navigator.push(context,MaterialPageRoute(builder: (context)=> CenterStar()));

                          } else if (1 == index){

                            Navigator.push(context,MaterialPageRoute(builder: (context)=> CenterAlBahga()));
                          }else if (2 == index){

                            Navigator.push(context,MaterialPageRoute(builder: (context)=> CenterFlagMall()));

                          }else if(3==index){

                            Navigator.push(context,MaterialPageRoute(builder: (context)=> ServicesDreamLand()));


                          }

                        });

                      },

                      child: CardGrid(
                        title: modelDream[index].name,
                        image: modelDream[index].image,
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 10
                  )),

            ),

          ),

        ],
      ),

    );
  }
}