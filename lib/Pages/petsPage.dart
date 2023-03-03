import 'package:feed_your_pet/Pages/specificPetPage.dart';
import 'package:feed_your_pet/Models/trendingPets.dart';
import 'package:flutter/material.dart';
import '../Styles/Styles.dart';

class petsPage extends StatefulWidget {
  const petsPage({Key? key}) : super(key: key);

  @override
  State<petsPage> createState() => _petsPageState();
}

class _petsPageState extends State<petsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pet Category",style: TextStyle(fontFamily: 'Andika',color: Styles.defaultWhiteColor,fontWeight: FontWeight.bold),),
          centerTitle: true,backgroundColor: Styles.defaultGreenColor,
        ),
        body:GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.60),
          itemCount: trending.length,
          itemBuilder: (context,index){
            return InkWell(onTap: (){
              if (trending[index].name== "Dog")
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPetPage(petsType: "Dog",)));
              } else if(trending[index].name== "Cat"){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPetPage(petsType: 'Cat',)));
              }else if (trending[index].name== "Rabbit"){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPetPage(petsType: 'Rabbit',)));
              } else if (trending[index].name== "Tortoise"){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => specificPetPage(petsType: 'Tortoise',)));
              }else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Something Went Wrong')));
              }
            },child: petCards(index));
          },
        ),
      ),
    );
  }
  Widget petCards(int index) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(color: Styles.defaultLimeGreenColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Styles.defaultBlackColor.withOpacity(0.2),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ), //BoxShadow
          BoxShadow(
            color: Styles.defaultWhiteColor,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 170,
              width: 170,
              child: Image.asset(trending[index].image,fit: BoxFit.fill,),
              decoration: BoxDecoration(color: Styles.defaultWhiteColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Styles.defaultBlackColor.withOpacity(0.2),
                    offset: const Offset(
                      3.0,
                      3.0,
                    ),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Styles.defaultWhiteColor,
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
            ),
          ),
          // Divider(color: Colors.transparent,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: Text(trending[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),),
          ),
          // Divider(color: Colors.transparent,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: Text(trending[index].description,textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Styles.defaultBlackColor.withOpacity(0.6),fontFamily: 'Andika'),),
          ),
        ],
      ),
    ),
  );
}
