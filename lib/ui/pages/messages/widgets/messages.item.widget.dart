import 'package:contact_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contact_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contact_bloc_app/model/message.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MessageItemWidget extends StatelessWidget {
  Message message;
  MessageItemWidget({this.message});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: message.selected,
      selectedTileColor: Colors.red,
      onLongPress: () {
        context.read<MessagesBloc>().add(new SelectMessageEvent(message));
      },
      title: Row(
        mainAxisAlignment: (message.type == 'sent') ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          (message.type == 'sent') ? SizedBox(width: 40,) : SizedBox(width: 0,),
          Flexible(
            child: Container(
              color: (message.type == 'sent') ? Color.fromARGB(20, 0, 255, 0) : Color.fromARGB(20, 255, 255, 255),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: (message.type == 'sent') ? Colors.green : Colors.green, width: 1,)
              ),
              child: Text(
                  '${message.content} (${message.date.day}/${message.date.month}/${message.date.year}-${message.date.hour}'
                      ':${message.date.minute})'),
            ),
          ),
          (message.type == 'received') ? SizedBox(width: 40,) : SizedBox(width: 0,),
        ],
      ),
    );
  }
}