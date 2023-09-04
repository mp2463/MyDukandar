import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'URL.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});


  @override
  State<SignUp> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp> {
TextEditingController firstnamecntrl = TextEditingController();
TextEditingController lastnamecntrl = TextEditingController();
TextEditingController emailcntrl = TextEditingController();
TextEditingController passcntrl = TextEditingController();
TextEditingController repasscntrl = TextEditingController();
bool _obscureText = true;
bool _obscureTextRepass = true;



Future<void> senddata(String firstname, String lastname, String email, String pass) async {

//print(response);
try {
  final url = Uri.parse("$URL/demo/get_data.php");
  final response = await http.post(
      url,
      body: {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": pass,
      });
  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User Registered Successfully!!')));
  }
  else {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An Error Ocurred!! Please Try Again!!')));
  }
}
  catch(ab) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An Error Ocurred!! Please Try Again!!')));
  print(ab);

  }

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
          title: Text('SignUp',
          style: TextStyle(color: Colors.white),),

        ),
        body:
        SingleChildScrollView(
    child: Container(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,

    children: <Widget>[


    Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5),
    child: Text('First Name:') ),
    Container(
    width: MediaQuery.of(context).size.width,
    child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
    child:TextField(controller:firstnamecntrl,
      decoration: InputDecoration(hintText: 'Enter First Name',
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


    Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5),
    child: Text('Email:') ),
    Container(
    width: MediaQuery.of(context).size.width,
    child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
    child:TextField(controller: emailcntrl, decoration: InputDecoration(hintText: 'Enter Email Address',
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


    Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:5),
    child: Text('Password:')),
    Container(
    width: MediaQuery.of(context).size.width,
    child: Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
    child: TextField(
      controller: passcntrl,
      obscureText: _obscureText,
      decoration: InputDecoration(hintText: 'Enter Password',
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: Colors.red)),
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText; // Toggle the password visibility
          });
        },
      ),
    ),),)
    ),


    Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5),
    child: Text('Re-Enter Password:') ),
    Container(
    width: MediaQuery.of(context).size.width,
    child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
    child:TextField(
      controller: repasscntrl,
      obscureText: _obscureTextRepass,
      decoration: InputDecoration(hintText: 'Re-Enter Password',
    contentPadding: EdgeInsets.all(10),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
    color: Colors.black
    )
    ),
      suffixIcon: IconButton(
        icon: Icon(_obscureTextRepass ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            _obscureTextRepass = !_obscureTextRepass; // Toggle the password visibility
          });
        },
      ),
    ),
    )
    )
    ),

    Center(
    child: Padding(padding: EdgeInsets.only(top:20, bottom:10),
    child:ElevatedButton(
    onPressed: (){

      String firstname = firstnamecntrl.text.toString();
      String lastname = lastnamecntrl.text.toString();
      String email = emailcntrl.text.toString();
      String pass = passcntrl.text.toString();
      String repass = repasscntrl.text.toString();

      if(firstname.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('First Name Cannot Be Empty')));
      }
      else{
        if(lastname.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Last Name Cannot Be Empty')));
        }
        else{
          if(email.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email Cannot Be Empty')));
          }
          else{

            if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(email)){
              if(pass.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Cannot Be Empty')));
              }
              else{
              if(pass.length<5){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entered Password length must greater than 5 characters')));
              }
              else{
                if(repass.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Re-Entered Password Cannot Be Empty')));
                }
                else{
                  if(repass.length<5){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entered Password length must greater than 5 characters')));
                  }
                  else{
                    if(pass == repass){
                      senddata(firstname, lastname, email, pass);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entered Password Does Not Match The Re-Entered Password')));
                    }
                  }
                }
              }
              }
            }
            else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter Valid Email Address')));
      }
          }
        }
      }






    },
    child: Padding(padding: EdgeInsets.all(5),
    child:Text('SignUp') ,),
    ),
    )),

    ]
    ),
    )



      // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
