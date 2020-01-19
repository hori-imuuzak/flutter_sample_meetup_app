import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_bloc.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_event.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_state.dart';
import 'package:flutter_sample_meetup_app/models/event.dart';
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
            return _displaySuccess(state);
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

  Widget _displaySuccess(EventListSuccess state) {
    return StreamBuilder(
      stream: state.eventList,
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (!snapshot.hasData) {
          return _displayProgress();
        }

        if (snapshot.hasError) {
          return _displayFailure();
        }

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final event = snapshot.data[index];
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(event.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(event.date.toIso8601String())
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                          event.imageUrl,
                          fit: BoxFit.none,
                          height: 128
                        ),
                      ),
                      Text(event.description)
                    ]
                  )
                ]
              )
            );
          },
          itemCount: snapshot.data.length
        );
      }
    );
  }

  Widget _displayFailure() {
    return Center(
        child: const Text('Failure')
    );
  }
}