

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_pad/dataBase/database_helper.dart';
import 'package:note_pad/model/note_model.dart';

class EditScreen extends StatefulWidget {
  final int? id;
  final String? studentid;
  final String? name;
  final String? email;
  final String? department;
  final String? university;

  const EditScreen(
      {super.key,
      this.id,
      this.studentid,
      this.name,
      this.email,
      this.department,
      this.university});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController universityController = TextEditingController();





  @override
  void initState() {
    idController.text = widget.studentid!;
    nameController.text = widget.name!;
    emailController.text = widget.email!;
    departmentController.text = widget.department!;
    universityController.text = widget.university!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.purple,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text("Edit Screen")),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                  hintText: "Student Id",
                  labelText: "Student Id",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: departmentController,
                decoration: InputDecoration(
                  hintText: "Department",
                  labelText: "Department",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: universityController,
                decoration: InputDecoration(
                  hintText: "University",
                  labelText: "University",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async{

                  var updateNote = NoteModel(
                    id:widget.id!,
                    studentid: idController.text,
                    name: nameController.text,
                    email: emailController.text,
                    department:departmentController.text,
                    university: universityController.text,
                    datetime: DateFormat().add_jm().format(DateTime.now()),
                  );
                  await _dataBaseHelper.updateNote(updateNote);
                  Navigator.pop(context,true);
                  setState(() {

                  });

                },
                style: ElevatedButton.styleFrom(primary: Colors.purple),
                child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
