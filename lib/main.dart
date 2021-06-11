import 'package:contact_bloc_app/repositories/contacts.repo.dart';
import 'package:contact_bloc_app/repositories/messages.repo.dart';
import 'package:contact_bloc_app/ui/pages/contacts/contacts.page.dart';
import 'package:contact_bloc_app/ui/pages/contactsWithMessages/contacts.messages.page.dart';
import 'package:contact_bloc_app/ui/pages/messages/messages.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'bloc/contacts/contacts.bloc.dart';
import 'bloc/contacts/contacts.state.dart';
import 'bloc/messages/messages.bloc.dart';
import 'bloc/messages/messages.state.dart';
import 'enums/enums.dart';

void main() {
  GetIt.instance.registerLazySingleton(() => new ContactsRepository());
  GetIt.instance.registerLazySingleton(() => new MessagesRepository());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => MessagesBloc(
              initialState: MessagesState.initialState(),
              messagesRepository: GetIt.instance<MessagesRepository>(),
            )),
        BlocProvider(
            create: (context) => ContactsBloc(
              initialState: ContactsState(
                  contacts: [],
                  errorMessage: '',
                  requestState: RequestState.NONE),
              contactsRepository: GetIt.instance<ContactsRepository>(),
              messagesBloc: context.read<MessagesBloc>(),
            )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: MaterialColor(0xff1b1b34, {50: Color(0xff1b1b34), 100: Color(0xff1b1b34),
              200: Color(0xff1b1b34), 300: Color(0xff1b1b34), 400: Color(0xff1b1b34), 500: Color(0xff1b1b34),
              600: Color(0xff1b1b34), 700: Color(0xff1b1b34), 800: Color(0xff1b1b34), 900: Color(0xff1b1b34),
            })),
        routes: {
          '/contacts': (context) => ContactsPage(),
          '/messages': (context) => MessagesPage(),
          '/contactsWithMessages': (context) => ContactsWithMessages(),
        },
        initialRoute: '/messages',
      ),
    );
  }
}