import 'package:contact_bloc_app/model/message.model.dart';
import 'package:flutter/material.dart';

import 'messages.item.widget.dart';

class MessagesListWidget extends StatelessWidget {
  List<Message> messages;

  ScrollController scrollController = new ScrollController();

  MessagesListWidget({this.messages});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.hasClients) {
        this.scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
    return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) =>
            MessageItemWidget(message: this.messages[index]),
        separatorBuilder: (context, index) => Divider(color: Color(0xff1b1b34), height: 2,), itemCount: messages.length
    );
  }
}