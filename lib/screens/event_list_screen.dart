import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_bloc.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_event.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_state.dart';
import 'package:flutter_sample_meetup_app/repositories/firestore_event_list_repository.dart';

class EventListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final eventListBloc = EventListBloc(
      eventListRepository: FirestoreEventListRepository()
    );
    eventListBloc.dispatch(EventListLoad());

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: BlocBuilder<EventListBloc, EventListState>(
        builder: (context, state) {

          if (state is EventListInProgress) {
            return _displayProgress();
          }

          if (state is EventListSuccess) {
            return _displaySuccess();
          }

          if (state is EventListFailure) {
            return _displayFailure();
          }

          return Container();
        }
      )
    );
  }

  Widget _displayProgress() {
    return Center(
        child: CircularProgressIndicator()
    );
  }

  Widget _displaySuccess() {

  }

  Widget _displayFailure() {
    return Center(
        child: const Text('Failure')
    );
  }
}