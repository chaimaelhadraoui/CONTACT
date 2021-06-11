import 'package:contact_bloc_app/enums/enums.dart';
import 'package:contact_bloc_app/model/contact.model.dart';

import 'contacts.actions.dart';

class ContactsState {
  List<Contact> contacts;
  RequestState requestState;
  String errorMessage;
  ContactsEvents currentEvent;
  Contact currentContact;

  ContactsState({this.contacts, this.requestState, this.errorMessage, this.currentEvent, this.currentContact});
}