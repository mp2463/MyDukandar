import 'dart:convert';
import 'package:demo2/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'URL.dart';
import 'package:http/http.dart' as http;


class ManageProduct extends StatefulWidget {
  final String name;
  const ManageProduct({ required this.name });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<ManageProduct> createState() => _ManageProductPageState(namme:name);


//static void navigateToBookmarked(BuildContext context) {
//Navigator.push(context, MaterialPageRoute(builder: (context) => Bookmarked()));
//}

}

class _ManageProductPageState extends State<ManageProduct> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysShow;
  TextEditingController namecntrl = TextEditingController();
  TextEditingController categorycntrl  = TextEditingController();
  TextEditingController  brandcntrl  = TextEditingController();
  TextEditingController  colourcntrl  = TextEditingController();
  TextEditingController  sizecntrl  = TextEditingController();
  TextEditingController  gendercntrl  = TextEditingController();
  TextEditingController  ratecntrl  = TextEditingController();
  TextEditingController  pricecntrl  = TextEditingController();
  TextEditingController  quantitycntrl  = TextEditingController();
  List<dynamic> list =[];
  List<String> namelist = [];
  List<String> dropdownItems = [];
  List<String> size = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];
  List<String> gender = ['Male', 'Female',];
  String firstValue = '', selectedValue = '', newvalue = '';
  final String namme;
  _ManageProductPageState({ required this.namme });







  Future<void> sendinventorydata(String name, String category, String brand, String colour, String size, String gender, String rate, String price, String quantity) async {

//print(response);

      final url = Uri.parse("$URL/demo/getinventorydata.php");
      final response = await http.post(
          url,
          body: {

            "name": name,
            "category": category,
            "brand": brand,
            "colour": colour,
            "size": size,
            "gender": gender,
            "rate": rate,
            "price": price,
            "quantity": quantity

          });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Created Successfully')));
      if (response.statusCode == 200) {

        print('User Created Successfully');
      } else {

        print('User Creation Failed');
      }

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));

  }

  void fetchData(String name) async {
    final response = await http.post(
        Uri.parse('$URL/demo/fetchname.php'),
        body: {
          "name": name,
        }
    );

    if (response.statusCode == 200) {
      setState(() {
        list = json.decode(response.body);
        if (list.isNotEmpty) {

          namecntrl.text = list[0]['name'];
          brandcntrl.text = list[0]['brand'];
          gendercntrl.text = list[0]['gender'];
          ratecntrl.text = list[0]['rate'];
          quantitycntrl.text = list[0]['quantity'];
          pricecntrl.text = list[0]['price'];
          size = list[0]['size'];

        }
      });
    }
  }

  void updateData(String newname,String name, String brand, String gender, String rate, String quantity, String price ) async {
      final response = await http.post(
        Uri.parse('$URL/demo/updateinventory.php'),
        body: {
          'newname': newname,
          'name': name,
          'brand': brand,
          'gender': gender,
          'rate': rate,
          'quantity': quantity,
          'price': price
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

  Future<void> obtainData() async {
    final response = await http.post(Uri.parse('$URL/demo/name.php'));

    if (response.statusCode == 200) {
      final obtainedData = json.decode(response.body);
      setState(() {
        namelist = obtainedData.map<String>((item) => item['name'].toString()).toList();


      });

    } else {
      throw Exception('Failed to obtain data from the server');
    }
  }


  @override

  void initState() {

    super.initState();
    obtainData();
    fetchData(namme);
    pricecntrl.text = '0';
    ratecntrl.text = '0';
    quantitycntrl.text = '0';
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
          title: Text('Edit Product',
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.normal
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),


        body:   SingleChildScrollView(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[


                    Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5),
                        child: Text('Product Name:') ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                            child:TextField(controller:namecntrl,
                              decoration: InputDecoration(hintText: 'Enter Name Of The Product',
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
                        child: Text('Product Category:') ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                            child:TextField(controller: categorycntrl, decoration: InputDecoration(hintText: 'Enter Category Of The Product',
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
                        child: Text('Product Brand:') ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                            child:TextField(controller: brandcntrl, decoration: InputDecoration(hintText: 'Enter Brand Name Of The Product',
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
                        child: Text('Product Colour:') ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                            child:TextField(controller: colourcntrl, decoration: InputDecoration(hintText: 'Enter Colour Of The Product',
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


                    Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 25),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Product Size:',
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: size.isNotEmpty ? size[0] : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  size = [newValue!]; // Update the selected value as a list
                                });
                              },
                              items: size.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),


                    Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 25),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Gender:',
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: gender.isNotEmpty ? gender[0] : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  gender = [newValue!]; // Update the selected value as a list
                                });
                              },
                              items: ['Male', 'Female'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),


                    Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:5),
                        child: Text('Product Rate(In Rupees):')),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                            controller: ratecntrl,
                            onChanged: (value)
                            {
                              int rate_int = int.tryParse(value) ?? 0;
                              int qty_int = int.tryParse(quantitycntrl.text) ?? 0;

                              int price_int = rate_int*qty_int;
                              pricecntrl.text = price_int.toString();

                            },
                            decoration: InputDecoration(hintText: 'Enter Rate Of The Product',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: Colors.red)),
                            ),),)
                    ),


                    Padding(padding: EdgeInsets.only(left:10,top:0,right:0,bottom:5),
                        child: Text('Product Quantity:') ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child:Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                            child:TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                              controller: quantitycntrl,
                              onChanged: (value)
                              {
                                int rate_int = int.tryParse(ratecntrl.text) ?? 0;
                                int qty_int = int.tryParse(value) ?? 0;

                                int price_int = rate_int*qty_int;
                                pricecntrl.text = price_int.toString();

                              },
                              decoration: InputDecoration(hintText: 'Enter Number Of The Product Pieces ',
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                        color: Colors.black
                                    )
                                ),
                              ),
                            )
                        )
                    ),



                    Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:5),
                        child: Text('Product Total Price(In Rupees):')),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(padding: EdgeInsets.only(left:10,top:0,right:10,bottom:25),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                            controller: pricecntrl,
                            enabled: false,
                            decoration: InputDecoration(hintText: 'Enter Price Of The Product',
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(color: Colors.red)),
                            ),),)
                    ),




                    Center(
                        child: Padding(padding: EdgeInsets.only(top:20, bottom:10),
                          child:ElevatedButton(
                            onPressed: (){

                              String newname = namecntrl.text.toString();
                              String category = categorycntrl.text.toString();
                              String brand = brandcntrl.text.toString();
                              String colour = colourcntrl.text.toString();
                              String selectedSize = size.isNotEmpty ? size[0] : ''; // Use the 'size' variable directly
                              String selectedGender = gender.isNotEmpty ? gender[0] : '';
                              String rate = ratecntrl.text.toString();
                              String price = pricecntrl.text.toString();
                              String quantity = quantitycntrl.text.toString();

                              if(newname.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name Cannot Be Empty')));
                              }
                              else{
                                if(category.isEmpty){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Category Cannot Be Empty')));
                                }
                                else{
                                  if(brand.isEmpty){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Brand Name Cannot Be Empty')));
                                  }
                                  else{
                                    if(colour.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Colour Cannot Be Empty')));
                                    }
                                    else{
                                      if(selectedSize.isEmpty){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Size Cannot Be Empty')));
                                      }
                                      else{
                                        if(selectedGender.isEmpty){
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gender Cannot Be Empty')));
                                        }
                                        else{
                                          if(rate.isEmpty){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rate Cannot Be Empty')));
                                          }
                                          else{
                                            if(price.isEmpty){
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Price Cannot Be Empty')));
                                            }
                                            else{
                                              if(quantity.isEmpty){
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quantity Cannot Be Empty')));
                                              }
                                              else{
                                                updateData(newname,namme, brand, selectedGender, rate, price, quantity);
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            },
                            child: Padding(padding: EdgeInsets.all(5),
                              child:Text('Update'
                                  '') ,),
                          ),
                        )),


                  ]
              ),
            )
        )
    );
  }
}
