import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  late Client client;
  late Databases databases;

  static  const endpoint="https://cloud.appwrite.io/v1";
  static const projectId="6799ddca002904b08063";
  static const databasesId="6799de7b00244332b9b4";
  static const collectionId="6799de8700372687e110";

  AppwriteService(){
    client =Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases=Databases(client);
  }

  Future<List<Document>> getEmployeeDetails()async{
    try{
      final result =await databases.listDocuments(databaseId: databasesId, collectionId: collectionId);
      return result.documents;
    }catch(e){
      print("error loading tasks: $e");
      rethrow;
    }
  }

Future<Document> addNote(String title,String subtitle,String category,String date)async{
  try{
    final documentId=ID.unique();

    final result = await databases.createDocument(
      collectionId:collectionId,
      databaseId: databasesId,
      data:{
        "title":title,
        "subtitle":subtitle,
        "category":category,
        "date":date,
      },
      documentId:documentId,
    );
    return result;
  }catch(e){
    print("error creating note:$e");
    rethrow;
  }
}

Future<Document> updateNote(String documentId,String title,String subtitle,String category,String date)async{
  try{
    final result= await databases.updateDocument(
      collectionId:collectionId,
      databaseId: databasesId,
      documentId: documentId,
      data:{
       "title":title,
        "subtitle":subtitle,
        "category":category,
        "date":date,
      },
    );
    return result;
  }catch(e){
    print("error updating note:$e");
    rethrow;
  }
}

Future<void> deleteNote(String documentId)async{
  try{
    await databases.deleteDocument(
      collectionId:collectionId,
      documentId: documentId,
      databaseId: databasesId,
    );
  }catch(e){
    print("error updating note:$e");
    rethrow;
  }
}
}