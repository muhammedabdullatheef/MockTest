import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'ProfileModelClass.dart';



class UserProfiled extends StatefulWidget {
  const UserProfiled({super.key});

  @override
  State<UserProfiled> createState() => _UserProfiledState();
}

class _UserProfiledState extends State<UserProfiled> {
  List mylist = [];

  Future<void> getdata() async {
    var res =
    await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    print(res);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      mylist = data;
    } else {
      throw Exception("Api mistake");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Profile",style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),),
        ),
        backgroundColor: Colors.blue,
      ),
      body:
         FutureBuilder(
             future: getdata(),
             builder: (BuildContext context, snapshot) {
               return ListView.builder(
                   itemCount: mylist!.length,
                   itemBuilder: (_, index) {
                     return Center(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 10,right: 10,top: 3),
                         child: SizedBox(
                           height: 90,
                           child: Card(
                             color: Colors. white,
                             child: Row(
                               children: [
                                 SizedBox(width: 10,),
                                 Center(child: Icon(Icons.account_circle,color: Colors.black26,size: 70,)),
                                 SizedBox(width: 15,),
                                 Column(
                                   children: [
                                     Row(
                                       children: [
                                         Column(children: [
                                           SizedBox(height: 10,),
                                           Text("Name:"),
                                           Text("email:"),
                                           Text("Phone:"),
                                         ]),
                                         Column(
                                           children: [
                                             SizedBox(height: 10,),
                                             Text("${mylist![index]["name"]}"),
                                             Text("${mylist![index]["email"]}"),
                                             Text("${mylist![index]["phone"]}"),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                             elevation: 5,
                           ),
                         ),
                       ),
                     );
                   });
             }),
    );
  }
}
