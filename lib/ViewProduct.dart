import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ManageProduct.dart';
import 'URL.dart';


class inventory
{
  final String name;
  final String brand;
  final String gender;
  final String rate;
  final String quantity;
  final String price;

  inventory({
    required this.name,
    required this.brand,
    required this.gender,
    required this.rate,
    required this.quantity,
    required this.price
  });

  factory inventory.fromJson(Map<String, dynamic> json){
    return inventory(
        name: json['name'].toString(),
        brand: json['brand'].toString(),
        gender: json['gender'].toString(),
        rate: json['rate'].toString(),
        quantity: json['quantity'].toString(),
        price: json['price'].toString()
    );
  }

}


class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<ViewProduct> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProduct> {
  TextEditingController namecntrl = TextEditingController();
  TextEditingController categorycntrl  = TextEditingController();
  TextEditingController  brandcntrl  = TextEditingController();
  TextEditingController  colourcntrl  = TextEditingController();
  TextEditingController  sizecntrl  = TextEditingController();
  TextEditingController  gendercntrl  = TextEditingController();
  TextEditingController  ratecntrl  = TextEditingController();
  TextEditingController  pricecntrl  = TextEditingController();
  TextEditingController  quantitycntrl  = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  List<inventory> list =[];
  List<inventory> filteredList = [];


  bool search = false;

  String _searchQuery = '';

  void fetchnameData() async {
    final response = await http.post(Uri.parse('$URL/demo/retrieve_name.php'));

    if (response.statusCode == 200) {
      setState(() {
        final List<dynamic> values= jsonDecode(response.body);

        if(values!=null)
          {
            list.addAll(values.map((json) => inventory.fromJson(json)).toList());
            filteredList = list;

          }
      });
    }
  }



  void searchByName(String query) {

    setState(() {

      if(query.isEmpty || query == '')
      {
        print('empty');
        filteredList = list;
      }
      else
      {
        filteredList = list.where((user) => user.name.contains(query)).toList();
      }

    });

  }


  void deleteData( String name) async {
    final response = await http.post(
      Uri.parse('$URL/demo/deletename.php'),
      body: {

        'name':name,
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

  @override
  void initState() {
    super.initState();
    fetchnameData();
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
                Text('View Product',
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
                              searchByName(value);
                              // Perform search operation on each query change or update the UI accordingly
                              // Your code here...
                            },
                            onSubmitted: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                              searchByName(value);
                              // Perform search operation or update the UI accordingly
                              // Your code here...
                            },
                            decoration:
                            InputDecoration(
                              hintText: 'Search by Name, Brand, etc...',
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
                                  searchByName('');
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
                            return Card(
                              elevation: 4.0,
                              child: ListTile(

                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(children: [
                                            Text('Name:'),
                                            Text(filteredList[index].name),
                                            SizedBox(height: 5),
                                          ],),
                                          Row(children: [
                                            Text('Brand:'),
                                            Text(filteredList[index].brand),
                                            SizedBox(height: 5),
                                          ],),
                                          Row(children: [
                                            Text('Gender:'),
                                            Text(filteredList[index].gender)
                                          ],),

                                        ],),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Rate:'),
                                              Text(filteredList[index].rate),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Quantity:'),
                                              Text(filteredList[index].quantity),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Price:'),
                                              Text(filteredList[index].price),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ],),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        IconButton(onPressed: (){
                                          String name = filteredList[index].name;

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ManageProduct(name:name)),
                                          );

                                        }, icon: Icon(Icons.edit)),
                                        IconButton(onPressed: (){
                                          String name = filteredList[index].name;

                                          deleteData( name );
                                        }, icon: Icon(Icons.delete)),
                                      ],)


                                ],
                              )





                               )

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