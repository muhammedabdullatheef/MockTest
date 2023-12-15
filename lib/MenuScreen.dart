import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mocktest/SinglePage.dart';

import 'MockModelClass.dart';
import 'package:http/http.dart'as http;
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}
Future<MockModelClass> TodayMeals() async {
  var res = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?f=b"));
  print(res);
  if (res.statusCode == 200) {
    var img = MockModelClass.fromJson(jsonDecode(res.body));
    return img;
  } else {
    throw Exception("404 Error");
  }
}
class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Icon(Icons.menu,color: Colors.white,),
        title: Text("Menu",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
      ),
      body:FutureBuilder(
          future: TodayMeals(),
          builder: (BuildContext context,
              AsyncSnapshot<MockModelClass> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              List<Meals>? Meallist2= snapshot.data!.meals;
              return
                  GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                     crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                    itemCount:Meallist2!.length,
                    itemBuilder: (BuildContext context, int index) {
                    final meals= Meallist2[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SinglePage(meals: meals),));
                      },
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                Meallist2[index].strMealThumb!,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(Meallist2[index].strMeal!,style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),),
                          ],
                        ),
                      ),
                    );
                    },);
            } else {
              return Text("Error 404");
            }
          })
      );

  }
}

