import 'package:bloc/bloc.dart';
import 'package:contact_bloc_app/enums/enums.dart';
import 'package:contact_bloc_app/model/message.model.dart';
import 'package:contact_bloc_app/repositories/messages.repo.dart';
import 'package:flutter/material.dart';

import 'messages.actions.dart';
import 'messages.state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesRepository messagesRepository;

  MessagesBloc({@required MessagesState initialState, this.messagesRepository}) : super(initialState);

  @override
  Stream<MessagesState> mapEventToState(MessagesEvent event) async* {
    if (event is MessagesByContactsEvent) {
      yield MessagesState(requestState: RequestState.LOADING, messages: state.messages, currentMessageEvent: event,
          selectedMessages: state.selectedMessages, currentContact: event.payload);
      try {
        List<Message> data = await messagesRepository.allMessagesByContact(event.payload.id);
        yield MessagesState(requestState: RequestState.LOADED, messages: data, currentMessageEvent: event,
            selectedMessages: state.selectedMessages, currentContact: event.payload);
      } catch (e) {
        yield MessagesState(requestState: RequestState.ERROR, messages: state.messages, errorMessage: e.toString(),
            currentMessageEvent: event, selectedMessages: state.selectedMessages, currentContact: event.payload);
      }
    } else if (event is AddNewMessageEvent) {
      try {
        event.payload.date = DateTime.now();
        Message message = await messagesRepository.addNewMessage(event.payload);
        List<Message> data = [...state.messages];
        data.add(message);
        yield MessagesState(
            requestState: RequestState.LOADED, messages: data, currentMessageEvent: event, selectedMessages: state.selectedMessages,
            currentContact: state.currentContact);
      } catch (e) {
        yield MessagesState(requestState: RequestState.ERROR, messages: state.messages, errorMessage: e.message,
            currentMessageEvent: event, selectedMessages: state.selectedMessages, currentContact: state.currentContact);
      }
    } else if (event is SelectMessageEvent) {
      List<Message> messages = state.messages;
      List<Message> selected = [...state.selectedMessages];
      for (Message m in messages) {
        if (m.id == event.payload.id) {
          m.selected = !m.selected;
        }
        if (m.selected == true) {
          selected.add(m);
        } else {
          selected.removeWhere((element) => element.id == m.id);
        }
      }
      MessagesState messagesState = MessagesState(requestState: RequestState.LOADED, messages: messages, currentMessageEvent: event,
          selectedMessages: selected, currentContact: state.currentContact);
      yield messagesState;
    } else if (event is DeleteMessagesEvent) {
      List<Message> messages = state.messages;
      List<Message> selected = [...state.selectedMessages];
      for (Message m in selected) {
        try {
          await messagesRepository.deleteMessage(m);
          messages.removeWhere((element) => element.id == m.id);
          MessagesState messagesState = MessagesState(requestState: RequestState.LOADED, messages: messages,
              currentMessageEvent: event, selectedMessages: selected, currentContact: state.currentContact);
          yield messagesState;
        } catch (e) {
          MessagesState messagesState = MessagesState(requestState: RequestState.ERROR,messages: messages,
              currentMessageEvent: event, selectedMessages: selected, currentContact: state.currentContact);
          yield messagesState;
        }
      }
    }
  }
}