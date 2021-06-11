import 'package:bloc/bloc.dart';
import 'package:contact_bloc_app/bloc/messages/messages.actions.dart';
import 'package:contact_bloc_app/bloc/messages/messages.bloc.dart';
import 'package:contact_bloc_app/enums/enums.dart';
import 'package:contact_bloc_app/model/contact.model.dart';
import 'package:contact_bloc_app/repositories/contacts.repo.dart';

import 'contacts.actions.dart';
import 'contacts.state.dart';



class ContactsBloc extends Bloc<ContactsEvents, ContactsState>{
  ContactsRepository contactsRepository;
  MessagesBloc messagesBloc;
  ContactsBloc({ContactsState initialState, this.contactsRepository, this.messagesBloc}):super(initialState);


  @override
  Stream<ContactsState> mapEventToState(ContactsEvents event) async* {
    if(event is LoadAllContactsEvent){
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, currentEvent:event);
      try{
        List<Contact> data= await contactsRepository.allContacts();
        messagesBloc.add(new MessagesByContactsEvent(data[0]));
        yield ContactsState(contacts:data, requestState: RequestState.LOADED, currentEvent:event,currentContact: data[0]);
      } catch(e){
        yield ContactsState(contacts:state.contacts, requestState: RequestState.ERROR,errorMessage: e.message,currentEvent:event);
      }
    }else if (event is LoadStudentsEvents) {
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, currentEvent: event);
      try {
        List<Contact> data = await contactsRepository.contactsByType("Student");
        yield ContactsState(contacts: data, requestState: RequestState.LOADED, currentEvent: event);
      } catch (e) {
        yield ContactsState(contacts: state.contacts, requestState: RequestState.ERROR, errorMessage: e.message, currentEvent: event);
      }
    } else if (event is LoadDevelopersEvents) {
      yield ContactsState(contacts: state.contacts, requestState: RequestState.LOADING, currentEvent: event);
      try {
        List<Contact> data = await contactsRepository.contactsByType("Developer");
        yield ContactsState(contacts: data, requestState: RequestState.LOADED, currentEvent: event);
      } catch (e) {
        yield ContactsState(contacts: state.contacts, requestState: RequestState.ERROR, errorMessage: e.message, currentEvent: event);
      }
    }
  }
  }

