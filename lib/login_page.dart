import 'package:Gocomet/UI/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:Gocomet/utils/constants.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Gocomet/utils/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';



bool _obscureText = true;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Future<UserModel> createUser(String email, String password) async{
  final String apiUrl = "https://login.gocomet.com/api/v1/login";

  final response = await http.post(apiUrl, body: {
    'email': email,
    'password': password
  } );
  
  if(response.statusCode == 200){
    final String responseString = response.body;

    return userModelFromJson(responseString);
  }else{
    return null;
  }
}

class _LoginPageState extends State<LoginPage> {
  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      global.username = prefs.getString('username');
      global.password = prefs.getString('password');
      global.redirectUrl = prefs.getString('url');
      global.token = prefs.getString('token');
    });
    _usernameController.text = global.username;
    _passwordController.text = global.password;
  }
  UserModel _user;
  final formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: global.username);

  final _passwordController = TextEditingController(text: global.password);
  @override
  void initState() {
    getValue();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.blue[900],
      title: Text("  ")),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset('assets/images/gocomet.png'), 
                    
                    Text("Welcome Back!", textAlign: TextAlign.left, style: TextStyle(
                      fontSize: 20,
                      
                      color: Colors.blue[900],
                     ),),
                   
                    Text("Please login to your account", textAlign: TextAlign.left),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Enter Email",prefixIcon: Icon(Icons.person), labelText: "Company Email",),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      // obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter Password",prefixIcon: Icon(Icons.lock), labelText: "Password"),
                    ),
                    
                    SizedBox(
                      height: 60,
                      ),

                     
                    
                    RaisedButton(
                      onPressed: () async {
                        //
                         final String email = _usernameController.text;
                         final String password = _passwordController.text;

                         final UserModel user = await createUser(email, password);

                         setState(() {
                           _user = user;
                         });
                          
                          _user != null ? login() :  _showMyDialog();
                      
                      },
                      
                      child: Text("Log in"),
                      color: Colors.blue[900],
              
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ), // coloumn
          ),
        ),
      ),
    );
    
  }
 
  void login() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('username', _usernameController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setString('url', _user.redirectUrl);
      await prefs.setString('token', _user.token);

    



      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }
  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert!',style: TextStyle(
                      
                      
                      color: Colors.red,
                     ),),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              
             
              Text('The email or password you entered is incorrect.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}