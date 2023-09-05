import 'package:demo2/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUp.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'URL.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login'),
      color: Colors.white,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _obscureText = true, remember = true, isChecked = false;
  TextEditingController  emailcntrl  = TextEditingController();
  TextEditingController  passcntrl  = TextEditingController();
   late SharedPreferences prefs;


  Future<void> senddata(String email, String pass) async {
    final url= Uri.parse("$URL/demo/fetch.php");
    final response = await http.post(
        url,
        body: {
          "email": email,
          "password": pass,
        });

    if(response.body == 'Data Found Successfully')
    {
      if(remember == true)
        {
          prefs.setString("email", email);

        }
      else
       {
        await prefs.remove("email");

       }
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect Email/Password. Please Try Again!!!')));

    }
  }

 Future<void> getpref() async
  {
    prefs = await SharedPreferences.getInstance();
  }


  @override
  void initState() {
    super.initState();

    getpref();

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
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
      ),
      body:
          SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[



                    Center(child: Image.asset('assets/Dukandar.png',
                      height: 180,
                      width: 280),),

                    SizedBox(height: 5),




                    Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5),
                        child: Text('Email:') ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                            child:TextField(
                              controller: emailcntrl,
                              decoration: InputDecoration(hintText: 'Enter Email Address',
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
                        child: Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:5),
                          child: TextField(
                            controller: passcntrl,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText; // Toggle the password visibility
                                  });
                                },
                              ),
                            ),
                          ))
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Switch(
                              activeColor: Colors.purple,
                      value: remember,
                      onChanged: (value) {
                        setState(() {
                          remember = value;
                        });
                      },
                    ),
                      ),


                        ],),
                    ),

                    Container(

                     child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                  print(isChecked);
                                });
                              },
                            ),
                          ),
                          Text('I Accept All Terms And Conditions.'),
                        ],
                      ),

                    ),



                    Center(
                        child: Padding(padding: EdgeInsets.only(top:0, bottom:10),
                          child:ElevatedButton(
                            onPressed: ()
                            {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                              String email = emailcntrl.text.toString();
                              String pass = passcntrl.text.toString();
                              if(email.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email Cannot Be Empty')));

                              }
                              else{
                                if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email))
                                {
                                  if(pass.isEmpty)
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Cannot Be Empty')));
                                  }
                                  else{
                                    if(pass.length<5)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Entered Password length must greater than 5 characters' )));

                                    }
                                    else{
                                      if(isChecked == true){
                                        senddata(email, pass);
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Accept All Terms And Conditions.')));
                                      }


                                    }
                                  }
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter Valid Email Address')));

                                }
                              }
                            },
                            child: Padding(padding: EdgeInsets.all(5),
                              child:Text('Login') ,),
                          ),
                        )),
                    Center(
                        child: InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));

                        },
                          child: Text('Not Registered? Click Here To Sign Up',
                          style: TextStyle(color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)))
                    ),
                    SizedBox(height: 28),
                  ]
              )
          )




      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
