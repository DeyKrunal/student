import 'package:flutter/material.dart';

import 'Login.dart';

class group extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: group_form(), // This sets the splash screen as the home screen
      // Set other configurations for your app here
    );
  }
}

class group_form extends StatefulWidget {
  const group_form({super.key});

  @override
  State<group_form> createState() => _group_formState();
}

class _group_formState extends State<group_form> {
  final formKey = GlobalKey<FormState>();
  String dropval = "TY-DIV-1";
  List<String> cityval = [
    "TY-DIV-1",
    "TY-DIV-2",
    "TY-DIV-3",
    "TY-DIV-4",
    "TY-DIV-5"
  ];

  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController cno = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1st Student Details'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/dashscreen.jpg', fit: BoxFit.fitWidth, width: 10000),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 700,
                      height: 700,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                              child: TextFormField(
                                controller: name,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person, color: Colors.black),
                                  labelText: "1st Student Name",
                                  hintText: "Enter Student name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Student name is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: rollno,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.edit_note, color: Colors.black),

                                  labelText: "Roll No",
                                  hintText: "Enter roll no",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Roll No is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(10,10,20,10),
                              child: Row(
                                children: [
                                  Icon(Icons.co_present),
                                  Text('  Division  : '  ,style: TextStyle(fontSize: 20),),
                                  DropdownButton(

                                    value: dropval,
                                    icon: Icon(Icons.arrow_drop_down,color: Colors.brown),
                                    dropdownColor: Colors.brown.shade100,
                                    onChanged:(String ?value){
                                      setState(() {
                                        dropval=value!;
                                      });
                                    },items: cityval.map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem(child: Text(value),value: value);


                                  }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: cno,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.phone, color: Colors.black),
                                  labelText: "Contact no",
                                  hintText: "Enter contact no",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Contact no is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email, color: Colors.black),
                                  labelText: "Email",
                                  hintText: "Enter email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              height: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 10, 50),
                                child: ElevatedButton(
                                  child: const Text('Next'),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      var _name = name.text;
                                      var _rno = rollno.text;
                                      var _cno = cno.text;
                                      var _email = email.text;
                                      var _div =  dropval.toString();
                                      _saveData1(_name,_rno,_cno,_email,_div);
                                      // var pwd = _passwordController.text;
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => Tab2(name1:_name,rno1:_rno,cno1:_cno,email1:_email,div1:_div)
                                          )
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                              Row(
                               children: [
                                 Padding(padding: EdgeInsets.fromLTRB(40,0,10,0),
                                   child: Center(
                                     child: Text(
                                       'Click on skip if group size is 1 ',
                                       style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                                     ),
                                   ),
                                 ),
                              Padding(padding: EdgeInsets.fromLTRB(0,0, 0, 0),
                              child:FloatingActionButton(
                                  onPressed: (){
                                    if (formKey.currentState!.validate()) {
                                      var _name = name.text;
                                      var _rno = rollno.text;
                                      var _cno = cno.text;
                                      var _email = email.text;
                                      var _div =  dropval.toString();
                                      _saveData1(_name,_rno,_cno,_email,_div);
                                      // var pwd = _passwordController.text;
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Tab5(name1:_name,rno1:_rno,cno1:_cno,email1:_email,div1:_div,name2:"",rno2:"",cno2:"",email2:"",div2:"",name3:"",rno3:"",cno3:"",email3:"",div3:"",name4:"",rno4:"",cno4:"",email4:"",div4:"")));
                                    }
                                  },
                                  backgroundColor: Colors.white,
                                  // style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50), // Adjust radius as needed
                                  ),
                                  // ),
                                  child:Icon(Icons.arrow_forward,color: Colors.black,size: 30,)
                              ),
                              ),
                               ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _saveData1(String name, String rno, String cno, String email, String div) async {
  print("Name = ${name}");
  print("Rollno = ${rno}");
  print("Cno = ${cno}");
  print("Email = ${email}");
  print("Div = ${div}");
}

//========================================================== Tab2 =====================================================
class Tab2 extends StatefulWidget {

  String name1,rno1,cno1,email1,div1;
  Tab2({super.key,required this.name1,required this.rno1,required this.cno1,required this.email1,required this.div1});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  final formKey = GlobalKey<FormState>();
  String dropval = "TY-DIV-1";
  List<String> cityval = [
    "TY-DIV-1",
    "TY-DIV-2",
    "TY-DIV-3",
    "TY-DIV-4",
    "TY-DIV-5"
  ];

  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController cno = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String name1 = widget.name1;
    String rno1 = widget.rno1;
    String cno1 = widget.cno1;
    String email1 = widget.email1;
    String div1 = widget.div1;

    return Scaffold(
      appBar: AppBar(
        title: Text('2nd Student Details'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/dashscreen.jpg', fit: BoxFit.fitWidth, width: 10000),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 700,
                      height: 700,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                              child: TextFormField(
                                controller: name,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person, color: Colors.black),
                                  labelText: "2nd Student Name",
                                  hintText: "Enter Student name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Student name is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: rollno,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(

                                  icon: Icon(Icons.edit_note, color: Colors.black),
                                  labelText: "Roll No",
                                  hintText: "Enter roll no",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Roll No is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(10,10,20,10),
                              child: Row(
                                children: [
                                  Icon(Icons.co_present),
                                  Text('  Division  : '  ,style: TextStyle(fontSize: 20),),
                                  DropdownButton(

                                    value: dropval,
                                    icon: Icon(Icons.arrow_drop_down,color: Colors.brown),
                                    dropdownColor: Colors.brown.shade100,
                                    onChanged:(String ?value){
                                      setState(() {
                                        dropval=value!;
                                      });
                                    },items: cityval.map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem(child: Text(value),value: value);


                                  }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: cno,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.phone, color: Colors.black),
                                  labelText: "Contact no",
                                  hintText: "Enter contact no",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Contact no is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email, color: Colors.black),
                                  labelText: "Email",
                                  hintText: "Enter email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              height: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 10, 50),
                                child: ElevatedButton(
                                  child: const Text('Next'),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      var _name2 = name.text;
                                      var _rno2 = rollno.text;
                                      var _cno2 = cno.text;
                                      var _email2 = email.text;
                                      var _div2 =  dropval.toString();
                                      _saveData2(_name2,_rno2,_cno2,_email2,_div2);
                                      // var pwd = _passwordController.text;
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Tab3(name1:name1,rno1:rno1,cno1:cno1,email1:email1,div1:div1,name2:_name2,rno2:_rno2,cno2:_cno2,email2:_email2,div2:_div2)));
                                    }
                                  },
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(40,0,10,0),
                                  child: Center(
                                    child: Text(
                                      'Click on skip if group size is 2',
                                      style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0,0, 0, 0),
                                  child:FloatingActionButton(
                                      onPressed: (){
                                        if (formKey.currentState!.validate()) {
                                          var _name2 = name.text;
                                          var _rno2 = rollno.text;
                                          var _cno2 = cno.text;
                                          var _email2 = email.text;
                                          var _div2 =  dropval.toString();
                                          _saveData2(_name2,_rno2,_cno2,_email2,_div2);
                                          // var pwd = _passwordController.text;
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Tab5(name1:name1,rno1:rno1,cno1:cno1,email1:email1,div1:div1,name2:_name2,rno2:_rno2,cno2:_cno2,email2:_email2,div2:_div2,name3:"",rno3:"",cno3:"",email3:"",div3:"",name4:"",rno4:"",cno4:"",email4:"",div4:"")));
                                        }
                                      },
                                      backgroundColor: Colors.white,
                                      // style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50), // Adjust radius as needed
                                      ),
                                      // ),
                                      child:Icon(Icons.arrow_forward,color: Colors.black,size: 30,)

                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _saveData2(String name2, String rno2, String cno2, String email2, String div2) async {
  print("Name2 = ${name2}");
  print("Rollno2 = ${rno2}");
  print("Cno2 = ${cno2}");
  print("Email2 = ${email2}");
  print("Div2 = ${div2}");
}

//========================================================== Tab3 =====================================================

class Tab3 extends StatefulWidget {
  String name1,rno1,cno1,email1,div1,name2,rno2,cno2,email2,div2;
  Tab3({super.key,required this.name1,required this.rno1,required this.cno1,required this.email1,required this.div1,required this.name2,required this.rno2,required this.cno2,required this.email2,required this.div2});

  @override
  State<Tab3> createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {

  final formKey = GlobalKey<FormState>();
  String dropval = "TY-DIV-1";
  List<String> cityval = [
    "TY-DIV-1",
    "TY-DIV-2",
    "TY-DIV-3",
    "TY-DIV-4",
    "TY-DIV-5"
  ];

  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController cno = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String name1 = widget.name1;
    String rno1 = widget.rno1;
    String cno1 = widget.cno1;
    String email1 = widget.email1;
    String div1 = widget.div1;
    String name2 = widget.name2;
    String rno2 = widget.rno2;
    String cno2 = widget.cno2;
    String email2 = widget.email2;
    String div2 = widget.div2;

    return Scaffold(
      appBar: AppBar(
        title: Text('3rd Student Details'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/dashscreen.jpg', fit: BoxFit.fitWidth, width: 10000),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 700,
                      height: 700,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                              child: TextFormField(
                                controller: name,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person, color: Colors.black),
                                  labelText: "3rd Student Name",
                                  hintText: "Enter Student name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Student name is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: rollno,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.edit_note, color: Colors.black),
                                  labelText: "Roll No",
                                  hintText: "Enter roll no",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Roll No is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(10,10,20,10),
                              child: Row(
                                children: [
                                  Icon(Icons.co_present),
                                  Text('  Division  : '  ,style: TextStyle(fontSize: 20),),
                                  DropdownButton(

                                    value: dropval,
                                    icon: Icon(Icons.arrow_drop_down,color: Colors.brown),
                                    dropdownColor: Colors.brown.shade100,
                                    onChanged:(String ?value){
                                      setState(() {
                                        dropval=value!;
                                      });
                                    },items: cityval.map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem(child: Text(value),value: value);


                                  }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: cno,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.phone, color: Colors.black),
                                  labelText: "Contact no",
                                  hintText: "Enter contact no",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Contact no is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email, color: Colors.black),
                                  labelText: "Email",
                                  hintText: "Enter email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              height: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 10, 50),
                                child: ElevatedButton(
                                  child: const Text('Next'),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      var _name3 = name.text;
                                      var _rno3 = rollno.text;
                                      var _cno3 = cno.text;
                                      var _email3 = email.text;
                                      var _div3 =  dropval.toString();
                                      _saveData3(_name3,_rno3,_cno3,_email3,_div3);
                                      // var pwd = _passwordController.text;
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Tab4(name1:name1,rno1:rno1,cno1:cno1,email1:email1,div1:div1,name2:name2,rno2:rno2,cno2:cno2,email2:email2,div2:div2,name3:_name3,rno3:_rno3,cno3:_cno3,email3:_email3,div3:_div3)));
                                    }
                                  },
                                ),
                              ),
                            ),              Row(
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(40,0,10,0),
                                  child: Center(
                                    child: Text(
                                      'Click on skip if group size is 3 ',
                                      style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.fromLTRB(0,0, 0, 0),
                                  child:FloatingActionButton(
                                      onPressed: (){
                                        if (formKey.currentState!.validate()) {
                                          var _name3 = name.text;
                                          var _rno3 = rollno.text;
                                          var _cno3 = cno.text;
                                          var _email3 = email.text;
                                          var _div3 =  dropval.toString();
                                          // var pwd = _passwordController.text;
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Tab5(name1:name1,rno1:rno1,cno1:cno1,email1:email1,div1:div1,name2:name2,rno2:rno2,cno2:cno2,email2:email2,div2:div2,name3:_name3,rno3:_rno3,cno3:_cno3,email3:_email3,div3:_div3,name4:"",rno4:"",cno4:"",email4:"",div4:"")));
                                        }
                                      },
                                      backgroundColor: Colors.white,
                                      // style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50), // Adjust radius as needed
                                      ),
                                      // ),
                                      child:Icon(Icons.arrow_forward,color: Colors.black,size: 30,)

                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _saveData3(String name3, String rno3, String cno3, String email3, String div3) async {
  print("Name3 = ${name3}");
  print("Rollno3 = ${rno3}");
  print("Cno3 = ${cno3}");
  print("Email3 = ${email3}");
  print("Div3 = ${div3}");
}

//========================================================== Tab4 =====================================================

class Tab4 extends StatefulWidget {

  String name1,rno1,cno1,email1,div1,name2,rno2,cno2,email2,div2,name3,rno3,cno3,email3,div3;
  Tab4({super.key,required this.name1,required this.rno1,required this.cno1,required this.email1,required this.div1,required this.name2,required this.rno2,required this.cno2,required this.email2,required this.div2,required this.name3,required this.rno3,required this.cno3,required this.email3,required this.div3});


  @override
  State<Tab4> createState() => _Tab4State();
}

class _Tab4State extends State<Tab4> {

  final formKey = GlobalKey<FormState>();
  String dropval = "TY-DIV-1";
  List<String> cityval = [
    "TY-DIV-1",
    "TY-DIV-2",
    "TY-DIV-3",
    "TY-DIV-4",
    "TY-DIV-5"
  ];

  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController cno = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String name1 = widget.name1;
    String rno1 = widget.rno1;
    String cno1 = widget.cno1;
    String email1 = widget.email1;
    String div1 = widget.div1;
    String name2 = widget.name2;
    String rno2 = widget.rno2;
    String cno2 = widget.cno2;
    String email2 = widget.email2;
    String div2 = widget.div2;
    String name3 = widget.name3;
    String rno3 = widget.rno3;
    String cno3 = widget.cno3;
    String email3 = widget.email3;
    String div3 = widget.div3;

    return Scaffold(
      appBar: AppBar(
        title: Text('4th Student Details'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/dashscreen.jpg', fit: BoxFit.fitWidth, width: 10000),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 700,
                      height: 700,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                              child: TextFormField(
                                controller: name,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person, color: Colors.black),
                                  labelText: "4th Student Name",
                                  hintText: "Enter Student name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Student name is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: rollno,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.edit_note, color: Colors.black),
                                  labelText: "Roll No",
                                  hintText: "Enter roll no",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Roll No is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(10,10,20,10),
                              child: Row(
                                children: [
                                  Icon(Icons.co_present),
                                  Text('  Division  : '  ,style: TextStyle(fontSize: 20),),
                                  DropdownButton(

                                    value: dropval,
                                    icon: Icon(Icons.arrow_drop_down,color: Colors.brown),
                                    dropdownColor: Colors.brown.shade100,
                                    onChanged:(String ?value){
                                      setState(() {
                                        dropval=value!;
                                      });
                                    },items: cityval.map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem(child: Text(value),value: value);


                                  }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: cno,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.phone, color: Colors.black),
                                  labelText: "Contact no",
                                  hintText: "Enter contact no",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Contact no is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email, color: Colors.black),
                                  labelText: "Email",
                                  hintText: "Enter email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              height: 120,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 10, 50),
                                child: ElevatedButton(
                                  child: const Text('Next'),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      var _name4 = name.text;
                                      var _rno4 = rollno.text;
                                      var _cno4 = cno.text;
                                      var _email4 = email.text;
                                      var _div4 =  dropval.toString();
                                      _saveData4(_name4,_rno4,_cno4,_email4,_div4);
                                      // var pwd = _passwordController.text;
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Tab5(name1:name1,rno1:rno1,cno1:cno1,email1:email1,div1:div1,name2:name2,rno2:rno2,cno2:cno2,email2:email2,div2:div2,name3:name3,rno3:rno3,cno3:cno3,email3:email3,div3:div3,name4:_name4,rno4:_rno4,cno4:_cno4,email4:_email4,div4:_div4)));
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _saveData4(String name4, String rno4, String cno4, String email4, String div4) async {
  print("Name4 = ${name4}");
  print("Rollno4 = ${rno4}");
  print("Cno4 = ${cno4}");
  print("Email4 = ${email4}");
  print("Div4 = ${div4}");
}

//========================================================== Tab5 =====================================================

class Tab5 extends StatefulWidget {
  late String name1,rno1,cno1,email1,div1 = "";
  late String name2,rno2,cno2,email2,div2 = "";
  late String name3,rno3,cno3,email3,div3 = "";
  late String name4,rno4,cno4,email4,div4 = "";

  Tab5({super.key,required this.name1,required this.rno1,required this.cno1,required this.email1,required this.div1,required this.name2,required this.rno2,required this.cno2,required this.email2,required this.div2,required this.name3,required this.rno3,required this.cno3,required this.email3,required this.div3,required this.name4,required this.rno4,required this.cno4,required this.email4,required this.div4});
  @override
  State<Tab5> createState() => _Tab5State();
}

class _Tab5State extends State<Tab5> {
  bool _passwordVisible = true;
  bool _passwordVisible1 = true;
  final formKey = GlobalKey<FormState>();
  String dropval = "TY-DIV-1";
  List<String> cityval = [
    "TY-DIV-1",
    "TY-DIV-2",
    "TY-DIV-3",
    "TY-DIV-4",
    "TY-DIV-5"
  ];

  TextEditingController uid = TextEditingController();
  TextEditingController pwd = TextEditingController();
  TextEditingController cpwd = TextEditingController();


  @override
  Widget build(BuildContext context) {
    String name1 = widget.name1;
    String rno1 = widget.rno1;
    String cno1 = widget.cno1;
    String email1 = widget.email1;
    String div1 = widget.div1;

    String name2 = widget.name2;
    String rno2 = widget.rno2;
    String cno2 = widget.cno2;
    String email2 = widget.email2;
    String div2 = widget.div2;

    String name3 = widget.name3;
    String rno3 = widget.rno3;
    String cno3 = widget.cno3;
    String email3 = widget.email3;
    String div3 = widget.div3;

    String name4 = widget.name4;
    String rno4 = widget.rno4;
    String cno4 = widget.cno4;
    String email4 = widget.email4;
    String div4 = widget.div4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Project and Group Details'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('assets/dashscreen.jpg', fit: BoxFit.fitWidth, width: 10000),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 700,
                      height: 700,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                              child: TextFormField(
                                controller: uid,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person, color: Colors.black),
                                  labelText: "Create User Id",
                                  hintText: "Enter User Id",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Project or Group name is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),


                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: pwd,
                                keyboardType: TextInputType.text,
                                obscureText:_passwordVisible,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock, color: Colors.black),
                                  labelText: "Create Password",
                                  hintText: "Create Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,color: Colors.black,),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: TextFormField(
                                controller: cpwd,
                                keyboardType: TextInputType.text,
                                obscureText:_passwordVisible1,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock, color: Colors.black),
                                  labelText: "Confirm Password",
                                  hintText: "Confirm Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(_passwordVisible1 ? Icons.visibility_off : Icons.visibility,color: Colors.black,),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible1 = !_passwordVisible1;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Confirm Password is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(40,0,10,10),
                              child: Center(
                                child: Container(
                                  color: Colors.white,
                                  child: Text(
                                    '**Remember user id and password for login ',
                                    style: TextStyle(fontSize: 15,color: Colors.red[500],fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              height: 140,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 10, 70),
                                child: ElevatedButton(
                                  child: const Text('Submit',style: TextStyle(fontSize: 20,color: Colors.deepPurple),),
                                  onPressed: () {

                                    if (formKey.currentState!.validate()) {
                                      var groupName = uid.text;
                                      var _pwd = pwd.text;
                                      var _cpwd = cpwd.text;
                                      if(_pwd==_cpwd)
                                        {
                                          _saveDataf(groupName,_pwd,name1,rno1,cno1,email1,div1,name2,rno2,cno2,email2,div2,name3,rno3,cno3,email3,div3,name4,rno4,cno4,email4,div4);
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                        }
                                      else{
                                        final snackBar = SnackBar(
                                          content: Text('Password unmatched...'),
                                          duration: Duration(seconds: 3), // Adjust the duration as needed
                                        );

                                        // Show the snackbar
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }

                                      // var pwd = _passwordController.text;

                                    }
                                  },
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _saveDataf(String groupName, String pwd,String name1,String rno1,String cno1,String email1,String div1,String name2,String rno2,String cno2,String email2,String div2,String name3,String rno3,String cno3,String email3,String div3,String name4,String rno4,String cno4,String email4,String div4) async {
  print("============= Final Data ===========");
  print("Group Name = ${groupName}");
  print("Password = ${pwd}");

  print("======== Tab1 ========");
  print("Name1 = ${name1}");
  print("Roll no1 = ${rno1}");
  print("Cno1 = ${cno1}");
  print("Email1 = ${email1}");
  print("Div1 = ${div1}");

  print("======== Tab2 ========");
  print("Name2 = ${name2}");
  print("Roll no2 = ${rno2}");
  print("Cno2 = ${cno2}");
  print("Email2 = ${email2}");
  print("Div2 = ${div2}");

  print("======== Tab3 ========");
  print("Name3 = ${name3}");
  print("Roll no3 = ${rno3}");
  print("Cno3 = ${cno3}");
  print("Email3 = ${email3}");
  print("Div3 = ${div3}");

  print("======== Tab3 ========");
  print("Name4 = ${name4}");
  print("Roll no4 = ${rno4}");
  print("Cno4 = ${cno4}");
  print("Email4 = ${email4}");
  print("Div4 = ${div4}");


}



