import 'package:contact_bloc_app/enums/enums.dart';
import 'package:contact_bloc_app/model/contact.model.dart';
import 'package:contact_bloc_app/model/message.model.dart';

import 'messages.actions.dart';

class MessagesState {
  RequestState requestState;
  List<Message> messages;
  String errorMessage;
  MessagesEvent currentMessageEvent;
  List<Message> selectedMessages = [];
  Contact currentContact;

  MessagesState({this.requestState, this.messages, this.errorMessage, this.currentMessageEvent,
    this.selectedMessages, this.currentContact});
  MessagesState.initialState(): messages = [], errorMessage = '', requestState = RequestState.NONE,
        selectedMessages = [], currentContact = new Contact();
}