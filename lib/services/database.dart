import 'package:brew_crew/models/brew.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:brew_crew/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars' : sugars,
      'name'   : name,
      'strength': strength, 
    });
  }

//brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Brew(
        sugars: doc.data['sugars'] ?? '0', 
        name: doc.data['name'] ?? '', 
        strength: doc.data['strength'] ?? 0,
        );
    }).toList();
  }

//userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
      );
  }
//get brew streams
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

//get user document stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
     
  }
}