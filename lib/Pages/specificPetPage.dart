import 'package:feed_your_pet/Pages/petDetailPage.dart';
import 'package:feed_your_pet/Models/trendingPets.dart';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import '../Styles/Styles.dart';

class specificPetPage extends StatefulWidget {
  final String petsType;
  const specificPetPage({Key? key, required this.petsType}) : super(key: key);

  @override
  State<specificPetPage> createState() => _specificPetPageState();
}

class _specificPetPageState extends State<specificPetPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(widget.petsType);
    if (widget.petsType== "Dog")
    {
      return SpecificWidgetBuild(pets: dogs,type: "Dogs");
    } else if(widget.petsType== "Cat"){
      return SpecificWidgetBuild(pets: cats,type: "Cats"
      );
    }else if (widget.petsType== "Rabbit"){
      return SpecificWidgetBuild(pets: dogs,type: "Rabbit",);

    } else if (widget.petsType== "Tortoise"){
      return SpecificWidgetBuild(pets: cats,type: "Tortoise",);

    }else {
      return Text('Something Went Wrong');
    }
  }
}

class SpecificWidgetBuild extends StatelessWidget {
  const SpecificWidgetBuild({Key? key, required this.pets, required this.type}) : super(key: key);
  final List<Pets> pets;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defaultWhiteColor,
      appBar: AppBar(
        title: Text(type,style: TextStyle(color: Styles.defaultWhiteColor,fontFamily: 'Andika',fontWeight: FontWeight.bold),),
        backgroundColor: Styles.defaultGreenColor,
        iconTheme: IconThemeData(color: Styles.defaultWhiteColor),
      ),
      body: SizedBox(
        // height: size.height * 0.25,
        child: GridView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: pets.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => petDetailPage(pets: pets[index],)));
                },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: Styles.defaultLimeGreenColor,
                      borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Styles.defaultBlackColor.withOpacity(0.4),
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
                        padding: EdgeInsets.all(10),
                        child: Container(
                          // width: 250,
                          child: Image.asset(pets[index].image,fit: BoxFit.scaleDown,),
                          decoration: BoxDecoration(color: Styles.defaultWhiteColor.withOpacity(0.9),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Column(
                          children: [
                            Container(child: Text(pets[index].type, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Styles.defaultWhiteColor,fontFamily: 'Andika'),)),
                            SizedBox(height: 5,),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: FivePointedStar(
                                  defaultSelectedCount: pets[index].difficulty.length,
                                  selectedColor: Styles.defaultYellowColor,
                                  onChange: null,

                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Container(
                              height: 30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                  color: Styles.defaultWhiteColor.withOpacity(0.9)
                              ),
                              child: Text("Choose",textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Styles.defaultGreenColor,fontFamily: 'Andika'),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.60),
        ),
      ),
    );
  }
}
