import 'package:brew_crew/services/auth.dart';
import "package:flutter/material.dart";
import "package:brew_crew/shared/constants.dart";
import "package:brew_crew/shared/loading.dart";

class Register extends StatefulWidget {

  final Function toggleValue;
  Register({this.toggleValue});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  
  //textfield state
  String email = "";
  String password = "";
  String error = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleValue();
            }, 
            icon: Icon(Icons.person), 
            label: Text("Sign In"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (value) => value.isEmpty ? "Enter an email" : null,
                    onChanged: (value){
                      setState(() {
                        email = value;
                      });
                    }
                  ),

                  SizedBox(height: 20),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Password"),
                    validator: (value) => value.length < 6 ? "Enter a password 6+ chars long" : null,
                    obscureText: true,  //for password
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    }
                  ),

                  SizedBox(height: 20),
                  
                  RaisedButton(
                    color: Colors.pink[400],
                    elevation: 0.0,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                      ),
                    onPressed: () async{
                      if(_formKey.currentState.validate())
                      {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authService.registerWithEmailAndPassword(email,password);

                        if(result == null)
                        setState(() {
                          error = "Please supply a valid email!";
                          loading = false;
                        });
                      }
                    }
                  ),
                  SizedBox(height: 12,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  )
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}