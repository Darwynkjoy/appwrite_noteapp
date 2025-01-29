import 'package:flutter/material.dart';

class Notepage extends StatefulWidget{
  @override
  State<Notepage> createState()=> _NotepageState();
}
class _NotepageState extends State<Notepage>{

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
          itemCount: 15,
          itemBuilder: (context,index){
            return Container(
              decoration: BoxDecoration(border: Border.all(width: 2,color: const Color.fromARGB(255, 189, 142, 0)),borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.amber),overflow: TextOverflow.clip,),
                  Text("Category",style: TextStyle(fontSize: 18),),
                  Text("Subtitle",style: TextStyle(fontSize: 16),overflow: TextOverflow.clip,maxLines: 4,),
                  Spacer(),
                  Row(
                    children: [
                      Text("date",style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 255, 191, 0))),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.amber,)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.amber,))
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
          return Container(
            height: 300,
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
                      Navigator.pop(context);
                    }, child: Text("ADD",style: TextStyle(fontSize: 20,color: Colors.white),))
                ],
              ),
            ),
          );
        });
      },
      child: Icon(Icons.add,color: Colors.white,),),
    );
  }
}