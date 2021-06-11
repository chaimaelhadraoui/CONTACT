import 'package:contact_bloc_app/bloc/contacts/contacts.bloc.dart';
import 'package:contact_bloc_app/bloc/contacts/contacts.state.dart';
import 'package:contact_bloc_app/enums/enums.dart';
import 'package:contact_bloc_app/ui/pages/contacts/widgets/contacts.bar.buttons.dart';
import 'package:contact_bloc_app/ui/pages/contacts/widgets/contacts.list.dart';
import 'package:contact_bloc_app/ui/shared/circular.progress.indicator.widget.dart';
import 'package:contact_bloc_app/ui/shared/error.retry.action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Column(
        children: [
          ContactsBarButtons(),
          Expanded(
            child: BlocBuilder<ContactsBloc, ContactsState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state.requestState == RequestState.LOADING) {
                  return MyCircularProgressIndicatorWidget();
                } else if (state.requestState == RequestState.ERROR) {
                  return ErrorRetryMessage(
                    errorMessage: state.errorMessage,
                    onAction: () {
                      context.read<ContactsBloc>().add(state.currentEvent);
                    },
                  );
                } else if (state.requestState == RequestState.LOADED) {
                  return ContactsList(
                    contacts: state.contacts,
                  );
                } else if (state.requestState == RequestState.NONE) {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
