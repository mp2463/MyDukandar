import 'package:demo2/RegisterProduct.dart';
import 'package:demo2/RegisteredUsers.dart';
import 'package:demo2/ViewUsers.dart';
import 'package:demo2/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Charts.dart';
import 'LineGraph.dart';
import 'ViewProduct.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<HomePage> createState() => _HomePageState();


  //static void navigateToBookmarked(BuildContext context) {
  //Navigator.push(context, MaterialPageRoute(builder: (context) => Bookmarked()));
  //}

  }

  class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysShow;
  TextEditingController firstnamecntrl = TextEditingController();
  TextEditingController lastnamecntrl  = TextEditingController();
  TextEditingController  emailcntrl  = TextEditingController();
  TextEditingController  passcntrl  = TextEditingController();
  TextEditingController  repasscntrl  = TextEditingController();
  List<dynamic> list =[];
  List<String> firstnamelist = [];
  List<String> dropdownItems = [];
  String firstValue = '',newdate = '', selectedValue = '';
  int months = 0;
  String sidebar_email = '';
  late SharedPreferences prefs;




  Future<void> _confirmLogout() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()),);
              },
              child: const Text('Yes'),
            ),

            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the AlertDialog
              },
              child: const Text('No'),
            ),

          ],
        );
      },
    );
  }

  Future<void> getpref() async
  {
    prefs = await SharedPreferences.getInstance();

    sidebar_email = prefs.getString("email")!;

    if(sidebar_email != null)
    {
      print(sidebar_email);
    }
  }

  @override

  void initState() {
    getpref();
    DateTime currentDate = DateTime.now();
    DateTime newDate = DateTime(currentDate.year,currentDate.month + months, currentDate.day);
    newdate = DateFormat('dd-MMMM-yyyy').format(newDate);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Home Page',
          style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.normal
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Admin: Mohil Chaturvedi'),
              accountEmail: Text('Email: $sidebar_email\nDate: $newdate'),
              currentAccountPicture: Container(
                width: 50, // Set the desired width
                height: 50, // Set the desired height
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/Dukandar.png'),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.deepPurple[200]
              ),
            ),
            ListTile(
              title: Text('View Users'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUsers()));
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: Text('Registered Users'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisteredUsers()));
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: Text('Bar Graph'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Charts()));
                // Handle item 1 tap
              },
            ),
            ListTile(
              title: Text('Line Graph'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LineGraph()));
                // Handle item 1 tap
              },
            ),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: _confirmLogout
            ),
            // Add more list items as needed
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });

          switch (index) {
          case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterProduct()));
          break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProduct()));
              break;
            default:
              break;
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Register Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'View Product',
          ),

        ],),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to Clothes Inventory Catalog Management App!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Add your description here
              Text(
                'This app helps you manage your Clothes Inventory catalog efficiently. '
                    'You can register, view products & visualize data with graphs. '
                    'Get started by registering your products and enjoy the features!',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Add images related to your app
              Image.asset('assets/home_image_1.jpg', height: 200),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the RegisterProduct screen when the button is pressed
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterProduct()));
                },
                child: Text('Get Started'),
              ),
            ],
          ),
        ),
      ),


    );
  }
}
