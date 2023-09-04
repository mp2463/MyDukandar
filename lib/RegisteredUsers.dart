import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ModifyUser.dart';
import 'URL.dart';


class RegisteredUsers extends StatefulWidget {
  const RegisteredUsers({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<RegisteredUsers> createState() => _RegisteredUsersPageState();
}

class _RegisteredUsersPageState extends State<RegisteredUsers> {
  TextEditingController firstnamecntrl = TextEditingController();
  TextEditingController lastnamecntrl  = TextEditingController();
  TextEditingController  emailcntrl  = TextEditingController();
  TextEditingController  passcntrl  = TextEditingController();
  TextEditingController  repasscntrl  = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  List<dynamic> list =[];
  List<dynamic> filteredList = [];


  bool search = false;

  String _searchQuery = '';

  void fetchData() async {
    final response = await http.get(Uri.parse('$URL/demo/retrieve.php'));

    if (response.statusCode == 200) {
      setState(() {
        list = json.decode(response.body);
        print(list);
        filteredList = list;
      });
    }
  }

  void deleteData( String email) async {
    final response = await http.post(
      Uri.parse('$URL/demo/delete.php'),
      body: {

        'email':email,
      },
    );

    if (response.statusCode == 200) {
      // Data deleted successfully
      print('Data deleted');
    } else {
      // Failed to delete data
      print('Failed to delete data');
    }
  }

  void searchByEmail(String query) {

    setState(() {

      if(query.isEmpty || query == '')
        {
          print('empty');
          filteredList = list;
        }
      else
        {
          print('filled');
          filteredList = list.where((user) => user['email'].contains(query)).toList();
        }

    });



  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Registered Users',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.normal
              ),
            ),
            IconButton(onPressed: (){
              setState(() {
                search = ! search; // Toggle the password visibility
              });
            }, icon: Icon(Icons.search), color: Colors.white)
          ],)
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [
                  Visibility(
                    visible: search,
                    child: Padding(padding: EdgeInsets.all(15),
                      child:  TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          searchByEmail(value);
                          // Perform search operation on each query change or update the UI accordingly
                          // Your code here...
                        },
                        onSubmitted: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                          searchByEmail(value);
                          // Perform search operation or update the UI accordingly
                          // Your code here...
                        },
                        decoration:
                        InputDecoration(
                          hintText: 'Search by Email',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                  color: Colors.black)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                              searchByEmail('');
                              // Clear search results or update the UI accordingly
                              // Your code here...
                            },
                          ),
                        ),
                      ),
                    )
                    ),



                    Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(

                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [Text(filteredList[index]['email']),
                                  Row(children: [
                                    IconButton(onPressed: (){
                                      String email = filteredList[index]['email'];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ModifyUser(email:email)),
                                      );

                                    }, icon: Icon(Icons.edit)),
                                    IconButton(onPressed: (){
                                      String email = filteredList[index]['email'];
                                      deleteData( email );
                                    }, icon: Icon(Icons.delete)),
                                  ],)
                                ],),


                            );
                          },
                        )
                    )
                    ,

                  ],
                )



            )));

  }
}