import 'package:appwrite/models.dart';

class notesData{
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String date;


  notesData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.date,
  });

  factory notesData.fromDocument(Document doc){
    return notesData(id: doc.$id, title: doc.data["title"], subtitle: doc.data["subtitle"], category: doc.data["category"], date: doc.data["date"]);
  }
}