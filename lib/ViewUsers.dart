import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'URL.dart';


class ViewUsers extends StatefulWidget {
  const ViewUsers({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<ViewUsers> createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsers> {
  TextEditingController firstnamecntrl = TextEditingController();
  TextEditingController lastnamecntrl  = TextEditingController();
  TextEditingController  emailcntrl  = TextEditingController();
  List<dynamic> list =[];
  List<String> firstnamelist = [];
  List<String> dropdownItems = [];
  String firstValue = '', selectedValue = '';

  void fetchData() async {
    final response = await http.post(Uri.parse('$URL/demo/retrieve.php'));

    if (response.statusCode == 200) {
      setState(() {
        list = json.decode(response.body);
        print(list);
      });
    }
  }
  Future<void> obtainData() async {
    final response = await http.post(Uri.parse('$URL/demo/firstname.php'));

    if (response.statusCode == 200) {
      final obtainedData = json.decode(response.body);
      setState(() {
        firstnamelist = obtainedData.map<String>((item) => item['email'].toString()).toList();
        firstValue = firstnamelist.first;
        getemail(firstValue);

      });

    } else {
      throw Exception('Failed to obtain data from the server');
    }
  }

  void getemail(String email) async {
    final response = await http.post(
        Uri.parse('$URL/demo/fetchemail.php'),
        body: {
          "email": email,
        }
    );

    if (response.statusCode == 200) {
      setState(() {
        list = json.decode(response.body);
        if (list.isNotEmpty) {

          firstnamecntrl.text = list[0]['firstname'];
          lastnamecntrl.text = list[0]['lastname'];
          emailcntrl.text = list[0]['email'];
        }
      });
    }
  }

  @override

  void initState() {

    super.initState();
    obtainData();
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
          title: Text('View Users',
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.normal
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),


        body: SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [


                    DropdownButtonFormField<String>(
                      padding: EdgeInsets.all(10),
                      value: firstValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          firstValue = newValue!;
                          getemail(firstValue);
                        });
                      },
                      items: firstnamelist.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),


                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5),
                           child: Text('First Name:') ),
                       Container(
                           width: MediaQuery.of(context).size.width,
                           child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                               child:TextField(controller:firstnamecntrl, decoration: InputDecoration(hintText: 'Enter First Name',
                                   contentPadding: EdgeInsets.all(10),
                                   border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(5),
                                       borderSide: BorderSide(
                                           color: Colors.black
                                       )
                                   )),
                               )
                           )
                       ),


                       Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5),
                           child: Text('Last Name:') ),
                       Container(
                           width: MediaQuery.of(context).size.width,
                           child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                               child:TextField(controller: lastnamecntrl, decoration: InputDecoration(hintText: 'Enter Last Name',
                                   contentPadding: EdgeInsets.all(10),
                                   border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(5),
                                       borderSide: BorderSide(
                                           color: Colors.black
                                       )
                                   )),
                               )
                           )
                       ),


                     ]
                    ),



                  ],
                )



            )));

  }
}