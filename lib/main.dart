import 'package:flutter/material.dart';
import 'package:task/add_note.dart';
import 'package:task/sql_llte/db_services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/add_note":(ctx)=>const AddNoteActivity()
      },
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task'),
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
    data =await DBServices.query();
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DBServices.initState().then((value) =>getData() );

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
      body:  data.length==0?Center(child:  Text("No Notes found"),):ListView.builder (
          itemCount: data.length,
          itemBuilder: (BuildContext context, int position) {
                 var value =data[position];
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      title: Text(value["title"],style: TextStyle(color: Colors.black),),
                      subtitle: Text(value["description"]),
                    ),
                  );
          }),

    floatingActionButton: FloatingActionButton(
        onPressed:()async{
         Map<String,dynamic> map=await Navigator.of(context).pushNamed("/add_note") as Map<String,dynamic>;
         data.add(map);
         setState(() {

         });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
