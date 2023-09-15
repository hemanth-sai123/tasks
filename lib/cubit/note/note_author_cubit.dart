
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../sql_llte/db_helper.dart';
import '../../sql_llte/db_services.dart';
import 'note_author_state.dart';


class NoteCubit extends Cubit<NoteState>{
  NoteCubit(): super(NoteInitialState()) {
   // _fetchPost();

  }
  static var  dbHelper = DatabaseHelper();
  Future<void> init() async{
    dbHelper=  await DBServices.initState();
    await dbHelper.init();
  }


  getAllList()async {
    emit(NotesLoadingState());
    try{
      var data =await DBServices.query(dbHelper);
      emit(NotesLoadedState(data));
    }
    catch(e){
      emit(NoteErrorState(""));
    }


  }

  void addNote(Map<String,dynamic> old) {

    final currentState = state;

    List<Map<String,dynamic>> oldNotes = [];
    if (currentState is NotesLoadedState) {
      oldNotes=currentState.notes.toList();
      oldNotes.add(old);
      emit(NotesLoadedState(oldNotes));
    }

  }

}