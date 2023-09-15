import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/sql_llte/db_services.dart';

import 'cubit/note/note_author_cubit.dart';



class AddNoteActivity extends StatefulWidget {
  const AddNoteActivity({super.key});

  @override
  State<AddNoteActivity> createState() => _AddNoteActivityState();
}

class _AddNoteActivityState extends State<AddNoteActivity> {
  TextEditingController _name=TextEditingController();
  TextEditingController _description=TextEditingController();
  @override
  Widget build(BuildContext context) {
    DBServices.initState();
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Add Note"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Title',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: _description,
              maxLines: 4,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Description',
              ),
            ),
          ),
          InkWell(
            onTap: () async{
              var map ={
                "title":_name.text.toString(),
                "description":_description.text.toString()
              };
              Navigator.of(context).pop();
              DBServices.insert(map);
              BlocProvider.of<NoteCubit>(context).addNote(map);


            },
            child: Container(

            margin: EdgeInsets.all(10),
              width:MediaQuery.of(context).size.width,
              padding: new EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              color: Colors.deepOrange,
              child: const Column(
                  children: [
                    Text("ADD",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
