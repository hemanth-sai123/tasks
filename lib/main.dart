import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/add_note.dart';
import 'package:task/sql_llte/db_services.dart';

import 'cubit/note/note_author_cubit.dart';
import 'cubit/note/note_author_state.dart';


void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [

          BlocProvider<NoteCubit>(
            create: (context) => NoteCubit(),
          ),


        ], child:MaterialApp(
      routes: {
        "/add_note":(ctx)=>const AddNoteActivity()
      },
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task'),
    )

    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List<Map<String, dynamic>> data=[];
 void getData() async{

    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // DBServices.initState().then((value) =>getData() );
    BlocProvider.of<NoteCubit>(context).init().then((value) =>   BlocProvider.of<NoteCubit>(context).getAllList());

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  Widget _blockBuilder(){
    return BlocBuilder<NoteCubit,NoteState>(
        builder:(context,state) {

          if (state is NoteInitialState) {
            return Center(child: CircularProgressIndicator(),);
          }

          if (state is NotesLoadedState) {
            return state.notes.isEmpty?const Center(child: Text("Empty list"),):ListView.builder (
                  itemCount: state.notes.length,
                  itemBuilder: (BuildContext context, int position) {
                         var value =state.notes[position];
                          return Card(
                            elevation: 2,
                            child: ListTile(
                              title: Text(value["title"],style: const TextStyle(color: Colors.black),),
                              subtitle: Text(value["description"]),
                            ),
                          );
                  });

          }


          if (state is NotesLoadingState) {
            return Center(child: CircularProgressIndicator(),);
          }


          return const Center(
            child: Text("error",style: TextStyle(color: Colors.black),),
          );

        }
    );
  }
  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _blockBuilder(),
      // body:  data.length==0?Center(child:  Text("No Notes found"),):ListView.builder (
      //     itemCount: data.length,
      //     itemBuilder: (BuildContext context, int position) {
      //            var value =data[position];
      //             return Card(
      //               elevation: 2,
      //               child: ListTile(
      //                 title: Text(value["title"],style: TextStyle(color: Colors.black),),
      //                 subtitle: Text(value["description"]),
      //               ),
      //             );
      //     }),

    floatingActionButton: FloatingActionButton(
        onPressed:()async{
        Navigator.of(context).pushNamed("/add_note") as Map<String,dynamic>;

        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
