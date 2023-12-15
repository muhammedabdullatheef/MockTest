import 'package:flutter/material.dart';
import 'package:mocktest/MockModelClass.dart';

class SinglePage extends StatefulWidget {
  const SinglePage({super.key, required this.meals});
  final Meals meals;
  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage(widget.meals.strMealThumb!),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.meals.strMeal!,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Divider(thickness: 3,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(right: 210),
                child: Text("Description:",style: TextStyle(fontSize: 20),),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Text(widget.meals.strInstructions!),
              ),
              SizedBox(height: 100,)
            ],
          ),
        ),
      ),
    );
  }
}
