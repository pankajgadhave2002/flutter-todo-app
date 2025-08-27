import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_list/Data/taskDB.dart';
import 'package:to_list/Models/to_do_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper? dbRef;

  

   
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController discriptionEdtingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();


 

  List<ToDoModel> taskList = [
   
  ];

  List<Color> listcolor = [
    Color.fromRGBO(250, 232, 232, 1),
    Color.fromRGBO(232, 237, 250, 1),
    Color.fromRGBO(250, 249, 232, 1),
    Color.fromRGBO(250, 232, 250, 1),
    Color.fromRGBO(250, 232, 232, 1),
  ];

  Widget Cards() {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                    bottom: 7,
                  ),
                  child: Container(
                    //height: 140,width: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: listcolor[index % listcolor.length],
                    ),

                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/image.svg",
                                    height: 80,
                                    width: 80,
                                  ),
                                  SvgPicture.asset(
                                    "assets/Group.svg",
                                    height: 25,
                                    width: 30,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      taskList[index].title,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      taskList[index].discription,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        color: Color.fromRGBO(135, 135, 135, 1),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  taskList[index].date,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    color: Color.fromRGBO(135, 135, 135, 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      titleEditingController.text=taskList[index].title;
                                      discriptionEdtingController.text=taskList[index].discription;
                                      dateEditingController.text=taskList[index].date;
                                      showBottomSheet(true,taskList[index]);
                                    },
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      color: Color(0xFF02A7B1),
                                      size: 19,
                                    ),
                                  ),
                                  // const SizedBox(width: 2,),
                                  IconButton(
                                    onPressed: () {
                                      taskList.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: Color(0xFF02A7B1),
                                      size: 19,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  void showBottomSheet(bool toedit,[ToDoModel? obj]) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
          
            children: [
              Text(
                "Create To-Do",
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row( mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Title",style: GoogleFonts.quicksand(color: Color.fromRGBO(0, 139, 148, 1),fontSize: 18),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: titleEditingController,
                  decoration: InputDecoration(
                    //labelText: "Title",
                    // hintText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Row( mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Discription",style: GoogleFonts.quicksand(color: Color.fromRGBO(0, 139, 148, 1),fontSize: 18),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: discriptionEdtingController,
                  maxLines: 4,
                  decoration: InputDecoration(
                   // labelText: 'Discription',
                    labelStyle: TextStyle(fontSize: 15),
                          
                    // hintText: 'Discription',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                  ),
                ),
              ),
          Row( mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Date",style: GoogleFonts.quicksand(color: Color.fromRGBO(0, 139, 148, 1),fontSize: 17),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextField(
                  
                  controller: dateEditingController,
                  onTap: () async{
                    DateTime? pickedDate = await showDatePicker(context: context, firstDate: DateTime(2023), lastDate: DateTime(2027));
                  dateEditingController.text=DateFormat.yMMMd().format(pickedDate!);
                  },
                  
                          
                  decoration: InputDecoration(
                    
                    suffixIcon: Icon(Icons.calendar_month),
                   // labelText: 'Date',
                    labelStyle: TextStyle(fontSize: 15),
                          
                    //hintText: 'Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                  ),
                ),
              ),
          
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    if(toedit){
                      submit(toedit,obj);
                    }else{
                      submit(toedit);
                    }
                        
                    
                    // ignore: non_constant_identifier_names
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF02A7B1)),
                  ),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

  
  }
     //SUBMIT BUTTON----------------
  void submit(bool toedit,[ToDoModel? obj]){
    if(titleEditingController.text.isNotEmpty && discriptionEdtingController.text.isNotEmpty && dateEditingController.text.isNotEmpty){
    if(toedit){
      obj!.title=titleEditingController.text;
      obj.discription=discriptionEdtingController.text;
      obj.date=dateEditingController.text;
    }else{
      taskList.add(
        ToDoModel(title: titleEditingController.text,  
        date:dateEditingController.text, discription: discriptionEdtingController.text)
      );
    }

    titleEditingController.clear();
    discriptionEdtingController.clear();
    dateEditingController.clear();
    }
    setState(() {
      
    });
    Navigator.of(context).pop();
    
  }


  


  // BUILD METHOD 
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color(0xFF02A7B1),
        titleSpacing: 16,
        leading: Padding(
          padding: const EdgeInsets.only(left: 19, top: 7),
          child: SvgPicture.asset(
            "assets/todo_logo.svg",
            height: 32,
            width: 32,
          ),
        ),

        title: Text(
          "To-do list",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
      body: Cards(),

      floatingActionButton: GestureDetector(
        onTap: () {
          showBottomSheet(false);
        },
        child: SvgPicture.asset(
          "assets/carbon_add-filled.svg",
          height: 67,
          width: 67,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
