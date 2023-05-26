import 'package:robot_kitten_assessment/domain/core/entities/crew.dart';
import 'package:robot_kitten_assessment/domain/core/entities/location.dart';

class EventDetails {
  final String title;
  final String description;
  final bool going;
  final DateTime startingDate;
  final DateTime endingDate;
  final List<Crew> squad;
  final Location location;

  const EventDetails({
    required this.title,
    required this.description,
    required this.going,
    required this.startingDate,
    required this.endingDate,
    required this.squad,
    required this.location,
  });
}
