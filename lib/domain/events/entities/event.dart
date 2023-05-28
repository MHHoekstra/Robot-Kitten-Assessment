import 'package:robot_kitten_assessment/domain/core/entities/crew.dart';

class Event {
  final DateTime date;
  final String city;
  final String state;
  final String title;
  final bool going;
  final List<Crew> squad;

  Event({
    required this.date,
    required this.city,
    required this.state,
    required this.title,
    required this.going,
    required this.squad,
  });
}
