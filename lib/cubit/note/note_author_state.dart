
abstract class NoteState{

}
//
 class NoteInitialState extends NoteState{}

class NotesLoadingState extends NoteState {

  NotesLoadingState();
}
class NotesLoadedState extends NoteState{
  List<Map<String, dynamic>> notes;
  NotesLoadedState(this.notes);
}


class NoteErrorState extends NoteState{
  final String error;
  NoteErrorState(this.error);
}
