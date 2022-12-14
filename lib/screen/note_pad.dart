import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_pad/screen/edit_screen.dart';

import '../dataBase/database_helper.dart';
import '../model/note_model.dart';


class NotePad extends StatefulWidget {
  const NotePad({Key? key}) : super(key: key);

  @override
  State<NotePad> createState() => _NotePadState();
}

class _NotePadState extends State<NotePad> {
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  bool loader = false;
  Random random = Random();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController universityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          inputDialogue();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.purple,
          title: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15),
            child: Center(child: Text("Note Pad ")),
          )),
      body: Container(
        child: loader
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        )
            : FutureBuilder(
          future: _dataBaseHelper.getNoteModel(),
          builder: (BuildContext context,
              AsyncSnapshot<List<NoteModel>?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong!"),
              );
            } else {
              if(snapshot.hasData){
                return ListView.builder(

                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async{
                          var data = await  Navigator.push(context, MaterialPageRoute(builder: (_)=> EditScreen(
                            id: snapshot.data![index].id,
                            studentid: snapshot.data![index].studentid,
                            name: snapshot.data![index].name,
                            email: snapshot.data![index].email,
                            department: snapshot.data![index].department,
                            university: snapshot.data![index].university,


                          )));
                          if(data!=null){
                            if(data==true){
                              setState(() {
                                _dataBaseHelper.getNoteModel();
                              });
                            }
                          }
                        },
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text("${snapshot.data![index].studentid}",
                                        style: TextStyle(fontSize: 18,color: Colors.black),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 12.0),
                                          child: Text("${snapshot.data![index].datetime}",
                                            style: TextStyle(fontSize: 18,color: Colors.black),

                                          ),
                                        ),
                                      ],
                                    ),

                                  ],

                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text("${snapshot.data![index].name}",
                                    style: TextStyle(fontSize: 18,color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text("${snapshot.data![index].email}",
                                    style: TextStyle(fontSize: 18,color: Colors.black),

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text("${snapshot.data![index].department}",
                                    style: TextStyle(fontSize: 18,color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text("${snapshot.data![index].university}",
                                    style: TextStyle(fontSize: 18,color: Colors.black),

                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        title: Text("Delete"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Are you sure want to Delete?"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                ElevatedButton(onPressed: (){
                                                  _dataBaseHelper.delete(snapshot.data![index].id!);
                                                  Navigator.pop(context);

                                                  setState(() {

                                                  });
                                                },
                                                    style: ElevatedButton
                                                        .styleFrom(primary: Colors.red),

                                                    child: Text("Yes")),
                                                SizedBox(width: 20,),
                                                ElevatedButton(onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: Text("No")),
                                                SizedBox(width: 20,),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });

                                  },
                                    child: Center(child: Icon(Icons.delete,color: Colors.red,size: 30,))),
                              ],

                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  inputDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: idController,
                      decoration: InputDecoration(
                        hintText: "Student Id",
                        label: Text("student id"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        label: Text("name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        label: Text("email"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: departmentController,
                      decoration: InputDecoration(
                        hintText: "Department",
                        label: Text("department"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: universityController,
                      decoration: InputDecoration(
                        hintText: "University",
                        label: Text("university"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          loader = true;
                        });

                        var noteModel = NoteModel(
                          id: random.nextInt(100),
                          studentid: idController.text,
                          name: nameController.text,
                          email: emailController.text,
                          department: departmentController.text,
                          university: universityController.text,
                          datetime:
                          DateFormat().add_jm().format(DateTime.now()),
                        );

                        await _dataBaseHelper.addNote(noteModel);
                        Navigator.pop(context);
                        idController.clear();
                        nameController.clear();
                        emailController.clear();
                        departmentController.clear();
                        universityController.clear();

                        setState(() {
                          loader = false;
                        });
                      },
                      child: Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                      )),
                ],
              ),
            ),
          );
        });
  }
}