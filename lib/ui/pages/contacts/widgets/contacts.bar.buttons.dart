import 'package:contact_bloc_app/bloc/contacts/contacts.actions.dart';
import 'package:flutter/material.dart';

import 'contacts.button.item.dart';

class ContactsBarButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContactsButtonItem(
            buttonLabel: 'All Contacts',
            contactsEvent: new LoadAllContactsEvent(),
          ),
          ContactsButtonItem(
            buttonLabel: 'Students',
            contactsEvent: new LoadStudentsEvents(),
          ),
          ContactsButtonItem(
            buttonLabel: 'Developers',
            contactsEvent: new LoadDevelopersEvents(),
          ),
        ],
      ),
    );
  }
}