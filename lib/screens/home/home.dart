import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import "package:brew_crew/services/database.dart";
import "package:provider/provider.dart";
import "brew_list.dart";
import 'package:brew_crew/models/brew.dart';
import 'settings_form.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context,builder: (context) {
        return Container(
          height: 900,
          color: Colors.red[50],
          padding : EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Brew Crew'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              }, 
              icon: Icon(Icons.person),
              label: Text('logout')
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),

          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList()),
      ),
    );
  }
}