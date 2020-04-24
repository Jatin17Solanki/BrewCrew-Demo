//import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import "package:brew_crew/shared/constants.dart";
import "package:brew_crew/shared/loading.dart";

class SignIn extends StatefulWidget {

  final Function toggleValue;
  SignIn({this.toggleValue});
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //textfield state
  String email = "";
  String password = "";

  bool loading = false;

  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign in to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleValue(); 
            }, 
            icon: Icon(Icons.person), 
            label: Text("Register"))
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
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                      ),
                    onPressed: () async{
                      if(_formKey.currentState.validate())
                          {
                           setState(() {
                             loading = true;
                           });
                           dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                            if(result == null)
                            setState(() {
                              error = "could not sign in these with credentials";
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