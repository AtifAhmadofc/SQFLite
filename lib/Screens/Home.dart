import 'package:flutter/material.dart';
import 'package:sqflite_implementation/Screens/HomeWithSQFHelper.dart';
import 'package:sqflite_implementation/Screens/HomeWithSQLQuries.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                color: Colors.black,
                child: TextButton(
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeWithSQLQuries()));
                    }, child: Text("With Raw Quries")
                ),
              ),
              Container(
                color: Colors.black,
                margin: EdgeInsets.symmetric(vertical: 5),

                child: TextButton(
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeWithSQFHelper()));
                    }, child: Text("With Helper")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
