import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

import 'CategoryModelClass.dart';
import 'MockModelClass.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Future<CatogaryModelClass> CategoryModel() async {
    var res = await http.get(
        Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));
    print(res);
    if (res.statusCode == 200) {
      var Catego = CatogaryModelClass.fromJson(jsonDecode(res.body));
      return Catego;
    } else {
      throw Exception("404 Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MockModelClass();
    CatogaryModelClass();
  }

  int curretIndux = 1;
  @override
  Widget build(BuildContext context) {
    double hit = MediaQuery.of(context).size.height;
    double wit = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Icon(Icons.home,color: Colors.white,),
          title: Text("Home",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Today's Meals",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: TodayMeals(),
                builder: (BuildContext context,
                    AsyncSnapshot<MockModelClass> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    List<Meals>? Meallist = snapshot.data!.meals;
                    return CarouselSlider.builder(
                      itemCount: Meallist!.length == 0 ? 0 : Meallist.length,
                      itemBuilder: (context, index, realIndex) => Card(
                        child: Column(
                          children: [
                            Container(
                              height: hit / 5.5,
                              width: wit,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          Meallist[index].strMealThumb!),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              Meallist[index].strMeal!,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        elevation: 5,
                      ),
                      options: CarouselOptions(
                        height: 180.0,
                        // enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 19 / 10,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 650),
                        viewportFraction: 0.8,
                      ),
                    );
                  } else {
                    return Text("Error 404");
                  }
                }),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
              child: FutureBuilder(
                  future: CategoryModel(),
                  builder: (BuildContext context,
                      AsyncSnapshot<CatogaryModelClass> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      List<Categories>? Categolist = snapshot.data!.categories;
                      return
                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5
                            ),
                            itemCount:Categolist!.length ,
                              itemBuilder: (context, index) =>
                              Card(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(
                                        Categolist[index].strCategoryThumb!
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(Categolist[index].strCategory!,style: TextStyle(
                                      fontWeight: FontWeight.w500
                                    ),)
                                  ],
                                ),
                              ),
                               );
                    }else{
                      return Text("Error 404");
                    }
                  }),
            )
          ],
        ));
  }
}
