import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'HomePage.dart';
import 'URL.dart';
import 'dart:convert';



class ModifyUser extends StatefulWidget {
  final String email;

  const ModifyUser({
    required this.email,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<ModifyUser> createState() => _ModifyUserPageState(emmail: email);
}

class _ModifyUserPageState extends State<ModifyUser> {
  TextEditingController firstnamecntrl = TextEditingController();
  TextEditingController lastnamecntrl  = TextEditingController();
  TextEditingController  emailcntrl  = TextEditingController();
  TextEditingController  passcntrl  = TextEditingController();
  TextEditingController  repasscntrl  = TextEditingController();

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final String emmail;

  _ModifyUserPageState(
      {
        required this.emmail,
      }
      );



  Future<void> senddata(String firstname, String lastname, String email, String pass) async {
    final url= Uri.parse("$URL/demo/get_data.php");
    final  response = await http.post(
        url,
        body: {
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          "password": pass,
        });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Created Successfully')));
    if (response.statusCode == 200) {

      print('User Created Successfully');
    } else {

      print('User Creation Failed');
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));



  }

  List<dynamic> list =[];
  void fetchData(String email) async {
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
          passcntrl.text = list[0]['password'];
          repasscntrl.text = list[0]['password'];
        }
      });
    }
  }

  void updateData(String firstname, String lastname, String email, String password ) async {
    final response = await http.post(
      Uri.parse('$URL/demo/update.php'),
      body: {

        'firstname': firstnamecntrl.text,
        'lastname': lastnamecntrl.text,
        'email': emailcntrl.text,
        'password': passcntrl.text,
      },
    );

    if (response.statusCode == 200) {
      // Data updated successfully
      print('Data updated');
    } else {
      // Failed to update data
      print('Failed to update data');
    }
  }




  @override
  void initState() {
    super.initState();
    fetchData(emmail);
  }
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
          title: Text('Modify User',
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.normal
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(


                child:Column(
                  // Column is also a layout widget. It takes a list of children and
                  // arranges them vertically. By default, it sizes itself to fit its
                  // children horizontally, and tries to be as tall as its parent.
                  //
                  // Column has various properties to control how it sizes itself and
                  // how it positions its children. Here we use mainAxisAlignment to
                  // center the children vertically; the main axis here is the vertical
                  // axis because Columns are vertical (the cross axis would be
                  // horizontal).
                  //
                  // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                  // action in the IDE, or press "p" in the console), to see the
                  // wireframe for each widget.
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[


                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left:10,top:20,right:0,bottom:5),
                              child:Text('First Name:') ,),

                            Container(
                                width: MediaQuery.of(context).size.width,
                                child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:0),
                                    child:TextField(controller: firstnamecntrl,decoration: InputDecoration(hintText: 'Enter Text',
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        )),
                                    )
                                )
                            )
                          ]
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left:10,top:20,right:0,bottom:5),
                              child:Text('Last Name:') ,),

                            Container(
                                width: MediaQuery.of(context).size.width,
                                child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:0),
                                    child:TextField(controller: lastnamecntrl, decoration: InputDecoration(hintText: 'Enter Text',
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        )),
                                    )
                                )
                            )
                          ]
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left:10,top:20,right:0,bottom:5),
                              child:Text('Email:') ,),

                            Container(
                                width: MediaQuery.of(context).size.width,
                                child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:0),
                                    child:TextField(controller: emailcntrl, decoration: InputDecoration(hintText: 'Enter Your Email Address', enabled: false,
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        )),
                                    )
                                )
                            )
                          ]
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left:10,top:20,right:0,bottom:5),
                              child:Text('Password:') ,),

                            Container(
                                width: MediaQuery.of(context).size.width,
                                child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:0),
                                    child:TextField(
                                      obscureText: _obscureText1,
                                      controller: passcntrl, decoration: InputDecoration(hintText: 'Enter Password',
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        ),
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText1 = !_obscureText1; // Toggle the password visibility
                                          });
                                        },
                                      ),
                                    ),
                                    )
                                )
                            )
                          ]
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.only(left:10,top:20,right:0,bottom:5),
                              child:Text('Re-Enter Password:') ,),

                            Container(
                                width: MediaQuery.of(context).size.width,
                                child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:0),
                                    child:TextField(
                                      obscureText: _obscureText2,
                                      controller: repasscntrl, decoration: InputDecoration(hintText: 'Enter Password',
                                        contentPadding: EdgeInsets.all(10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Colors.black
                                            )
                                        ),
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscureText2 ? Icons.visibility_off : Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText2 = !_obscureText2; // Toggle the password visibility
                                          });
                                        },
                                      ),
                                    ),
                                    )
                                )
                            ),
                            Center(
                                child: Padding(padding: EdgeInsets.only(top:20),child:ElevatedButton(
                                  onPressed: (){

                                    String firstname = firstnamecntrl.text.toString();
                                    String lastname = lastnamecntrl.text.toString();
                                    String email = emailcntrl.text.toString();
                                    String pass = passcntrl.text.toString();
                                    String repass = repasscntrl.text.toString();

                                    if(firstname.isEmpty)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('First Name Cannot Be Empty')));
                                    }
                                    else
                                    {
                                      if(lastname.isEmpty)
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Last Name Cannot Be Empty')));

                                      }
                                      else
                                      {
                                        if(email.isEmpty)
                                        {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email Cannot Be Empty')));
                                        }
                                        else
                                        {
                                          if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(email))
                                          {
                                            if(pass.isEmpty)
                                            {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Cannot Be Empty')));
                                            }
                                            else
                                            {
                                              if(pass.length<5)
                                              {
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entered Password length must greater than 5 characters' )));

                                              }
                                              else{
                                                if (repass.isEmpty)
                                                {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Re-Entered Password CannotEmpty')));
                                                }
                                                else
                                                {
                                                  if(repass.length<5)
                                                  {
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Re-Entered Password length must greater than 5 characters')));
                                                  }
                                                  else{
                                                    if (pass == repass){

                                                      updateData(firstname, lastname, email, pass);

                                                    }
                                                    else{
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Re-Entered Password does not match the Entered Password.')));

                                                    }
                                                  }
                                                }
                                              }

                                            }
                                          }
                                          else
                                          {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter Valid Email Address')));

                                          }

                                        }
                                      }
                                    }
                                  },
                                  child: Padding(padding: EdgeInsets.all(5),
                                    child:Text('Modify') ,),
                                )
                                  ,
                                ))

                          ]
                      )

                    ])



            )));

  }
}