import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_implementation/Models/DiaryModel.dart';
import 'package:sqflite_implementation/SqfHelpers/SqfHelper.dart';

class HomeWithSQLQuries extends StatefulWidget {
  HomeWithSQLQuries({Key? key, }) : super(key: key);



  @override
  _HomeWithSQLQuriesState createState() => _HomeWithSQLQuriesState();
}

class _HomeWithSQLQuriesState extends State<HomeWithSQLQuries> {
  List<DiaryModel> messagesList = [
    DiaryModel(title: "title", message: "message"),
    DiaryModel(title: "title", message: "message"),
    DiaryModel(title: "title", message: "message"),
    DiaryModel(title: "title", message: "message"),
  ];

  TextEditingController title=TextEditingController();
  TextEditingController message=TextEditingController();

  SqfHelper sqfHelper =SqfHelper();

  Future<void> _showDialogue(){


    return showDialog(
      context:context,
      builder: (context){
        return AlertDialog(
          title: Text("Add new message"),
          content: Wrap(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "Title"
                ),
              ),
              TextField(
                controller: message,
                decoration: InputDecoration(
                    hintText: "Message"
                ),
              ),
              TextButton(
                  onPressed: () async {
                    if(title.text.trim()!=""&&message.text.trim()!=""){
                      await sqfHelper.addData(title.text.trim(), message.text.trim());
                      // messagesList.add(DiaryModel(title: title.text.trim(), message: message.text.trim()));
                      title.clear();
                      message.clear();
                      setState(() { });
                    }
                    Navigator.pop(context);
                  }, child: Text("Add")
              )

            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Raw Queries"),
      ),
      body:
      FutureBuilder(
        future: sqfHelper.getData(),
        builder:(context, AsyncSnapshot<dynamic> snapshot ) {
          return ListView.builder(
              itemCount: snapshot.data==null?0:snapshot.data.length,
              itemBuilder: (context,index){

                DiaryModel data=DiaryModel.fromDb(snapshot.data[index]);
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.blue,

                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                          Text(
                            data.message,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          await sqfHelper.deleteData(data.Id!);
                          setState(() {
                          });
                        },
                        child: Icon(Icons.delete),
                      )
                    ],
                  ),
                );
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showDialogue();
          // sqfHelper.createDb();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
            size: 26,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}