import 'package:contact_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contact_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contact_bloc_app/bloc/messages/messages.state.dart';
import 'package:contact_bloc_app/model/contact.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactHorizontalItemWidget extends StatelessWidget {
  Contact contact;
  int index;
  ScrollController scrollController;

  ContactHorizontalItemWidget({this.contact, this.index, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          context.read<MessagesBloc>().add(new MessagesByContactsEvent(this.contact));
          this.scrollController.animateTo((this.index * 200 - 150).toDouble(),
              duration: Duration(microseconds: 2000), curve: Curves.ease);
        },
        child: BlocBuilder<MessagesBloc, MessagesState>(
          builder: (context, messagesState) => Card(
            elevation: 1,
            child: Container(
              padding: EdgeInsets.all(16),
              width: 150,
              child: Column(children: [
                CircleAvatar(
                  child: Text('${this.contact.profile}'),
                ),
                Text('${this.contact.name}'),
                Text('${this.contact.score}'),
              ]),
              decoration: BoxDecoration(
                border: Border.all(width: (messagesState.currentContact == this.contact) ? 3 : 1, color: Color(0xff1b1b34),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}