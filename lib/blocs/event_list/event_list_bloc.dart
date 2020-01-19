import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_state.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_event.dart';
import 'package:flutter_sample_meetup_app/blocs/event_list/event_list_repository.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  final EventListRepository _eventListRepository;

  EventListBloc({@required EventListRepository eventListRepository})
      : assert(eventListRepository != null),
        this._eventListRepository = eventListRepository;

  @override
  EventListState get initialState {
    return EventListEmpty();
  }

  @override
  Stream<EventListState> mapEventToState(EventListEvent event) async* {
    if (event is EventListLoad) {
      yield* _mapEventListLoadToState();
    }
  }

  Stream<EventListState> _mapEventListLoadToState() async* {
    yield EventListInProgress();
    try {
      yield EventListSuccess(eventList: _eventListRepository.fetch());
    } catch (e) {
      yield EventListFailure(error: e);
    }
  }
}
