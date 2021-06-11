import 'package:contact_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contact_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contact_bloc_app/model/contact.model.dart';
import 'package:contact_bloc_app/ui/pages/messages/widgets/contact.info.widget.dart';
import 'package:contact_bloc_app/ui/pages/messages/widgets/messages.app.bar;widget.dart';
import 'package:contact_bloc_app/ui/pages/messages/widgets/messages.form.widget.dart';
import 'package:contact_bloc_app/ui/pages/messages/widgets/messages.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatelessWidget {
  Contact contact;

  @override
  Widget build(BuildContext context) {
    this.contact = ModalRoute.of(context).settings.arguments as Contact;
    context.read<MessagesBloc>().add(MessagesByContactsEvent(this.contact));
    return Scaffold(
      appBar: MyAppBarWidget(
        contact: this.contact,
      ),
      body: Column(
        children: [
          ContactInfoWidget(
            contact: this.contact,
          ),
          MessagesWidget(),
          MessagesFormWidget(
            contact: this.contact,
          ),
        ],
      ),
    );
  }
}