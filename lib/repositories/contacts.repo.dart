import 'dart:math';

import 'package:contact_bloc_app/model/contact.model.dart';

class ContactsRepository{
  Map<int, Contact> contacts = {
    1: Contact(id: 1, name: 'Mohamed', profile: 'Mo', score: 1234, type: 'Student'),
    2: Contact(id: 2, name: 'Youssef', profile: 'YO', score: 2468, type: 'Developer'),
    3: Contact(id: 3, name: 'Hisham', profile: 'HI', score: 135, type: 'Student'),
    4: Contact(id: 4, name: 'Abdelilah', profile: 'AB', score: 57, type: 'Developer'),
    5: Contact(id: 5, name: 'Hamza', profile: 'HA', score: 468, type: 'Student'),
  };
  Future<List<Contact>> allContacts() async {
    var future = await Future.delayed(Duration(seconds: 1));
    int rnd = new Random().nextInt(10);
    if (rnd > 1) {
      return contacts.values.toList();
    } else {
      throw new Exception("Internet Error");
    }
  }
  Future<List<Contact>> contactsByType(String type) async{
    var future=await Future.delayed(Duration(seconds: 1));
    int rnd=new Random().nextInt(10);
    if(rnd>1){
      return contacts.values.toList().where((element) => element.type==type);
    }else{
      throw new Exception("Internet Error");
    }
  }
}