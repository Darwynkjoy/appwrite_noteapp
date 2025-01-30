import 'package:appwrite_noteapp/appwrite.dart';
import 'package:appwrite_noteapp/note_list.dart';
import 'package:flutter/material.dart';

class Notepage extends StatefulWidget{
  @override
  State<Notepage> createState()=> _NotepageState();
}
class _NotepageState extends State<Notepage>{

  late AppwriteService _appwriteService;
  late List<notesData> _notes;

  String? _editingNoteId; // track the id of the Notes being edited

   @override
  void initState(){
    super.initState();
    _appwriteService=AppwriteService();
    _notes=[];
    _loadNoteDetails();
  }

  Future <void> _loadNoteDetails()async{
    try{
      final tasks=await _appwriteService.getEmployeeDetails();
      setState(() {
        _notes = tasks.map((e) => notesData.fromDocument(e)).toList();
      });
    }catch(e){
      print("error loading tasks:$e");
    }
  }

  Future<void> _addOrUpdateNoteDetails()async{
    final Title=title.text;
    final Subtitle=subtitle.text;
    final Category=category.text;
    final Date=date.text;

    if(Title.isNotEmpty && Subtitle.isNotEmpty && Category.isNotEmpty && Date.isNotEmpty){
      try{
        if(_editingNoteId == null){
          await _appwriteService.addNote(Title, Subtitle, Category,Date);
        }else{
          await _appwriteService.updateNote(_editingNoteId!,Title, Subtitle, Category,Date);
        }
          title.clear();
          subtitle.clear();
          category.clear();
          date.clear();
          _editingNoteId = null;
          _loadNoteDetails();
      }catch(e){
        print("error adding or Deleting task:$e");
      }
    }
  }
    Future<void> _deleteNoteDetails(String taskId)async{
      try{
        await _appwriteService.deleteNote(taskId);
        _loadNoteDetails();
      }catch(e){
        print("error deleting task:$e");
      }
    }

  void _editNoteDetails(notesData note){
    title.text = note.title;
    subtitle.text=note.subtitle;
    category.text=note.category;
    date.text=note.date;
    _editingNoteId=note.id;
  }


TextEditingController title=TextEditingController();
TextEditingController subtitle=TextEditingController();
TextEditingController category=TextEditingController();
TextEditingController date=TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTE APP",style: TextStyle(fontSize: 30,color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 0.6),
          itemCount: _notes.length,
          itemBuilder: (context,index){
            final notesLists=_notes[index];
            return Container(
              decoration: BoxDecoration(border: Border.all(width: 2,color: const Color.fromARGB(255, 189, 142, 0)),borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${notesLists.title}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.amber),overflow: TextOverflow.clip,),
                  Text("${notesLists.category}",style: TextStyle(fontSize: 18),),
                  Text("${notesLists.subtitle}",style: TextStyle(fontSize: 16),overflow: TextOverflow.clip,maxLines: 4,),
                  Spacer(),
                  Row(
                    children: [
                      Text("${notesLists.date}",style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 255, 191, 0))),
                      Spacer(),

                      IconButton(onPressed: (){
                        _editNoteDetails(notesLists);
                        showModalBottomSheet(context: context, builder: (BuildContext context){
                          return _showNoteForm();
                        });
                      }, icon: Icon(Icons.edit,color: Colors.amber,)),

                      IconButton(onPressed: (){
                        _deleteNoteDetails(notesLists.id);
                      }, icon: Icon(Icons.delete,color: Colors.amber,))
                    ],
                  ),
                  
                ],
                            ),
              ));
          }),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: (){
        showModalBottomSheet(context: context, builder: (BuildContext context){
          return _showNoteForm();
        });
      },
      child: Icon(Icons.add,color: Colors.white,),),
    );
  }

  Widget _showNoteForm(){
    return Container(
            height: 350,
            width: 410,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: title,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    labelText: "Title",labelStyle: TextStyle(fontSize: 18,color: Colors.grey)),
                  ),
                  TextField(
                    controller: category,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    labelText: "Category",labelStyle: TextStyle(fontSize: 18,color: Colors.grey)),
                  ),
                  TextField(
                    controller: subtitle,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    labelText: "Subtitle",labelStyle: TextStyle(fontSize: 18,color: Colors.grey)),
                  ),
                  TextField(
                    controller: date,
                    decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
                    labelText: "date",labelStyle: TextStyle(fontSize: 18,color: Colors.grey)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    onPressed: (){
                      _addOrUpdateNoteDetails();
                      Navigator.pop(context);
                    }, child: Text(_editingNoteId == null ? "Add" : "Update",style: TextStyle(fontSize: 20,color: Colors.white),))
                ],
              ),
            ),
          );
  }
}