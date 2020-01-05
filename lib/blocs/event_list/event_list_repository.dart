import 'package:flutter_sample_meetup_app/models/event.dart';

abstract class EventListRepository {
  Stream<List<Event>> fetch();
}