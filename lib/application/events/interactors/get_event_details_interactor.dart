import 'package:dartz/dartz.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:robot_kitten_assessment/domain/core/entities/crew.dart';
import 'package:robot_kitten_assessment/domain/core/entities/failure.dart';
import 'package:robot_kitten_assessment/domain/core/entities/location.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event_details.dart';

final class GetEventDetailsInteractor {
  const GetEventDetailsInteractor();

  Future<Either<Failure, EventDetails>> call(Event event) {
    return Future.value(
      right(
        EventDetails(
          title: event.title,
          description: lorem(paragraphs: 1, words: 28),
          going: event.going,
          startingDate: event.date,
          endingDate: DateTime.now(),
          squad: [
            Crew(
              name: lorem(
                paragraphs: 1,
                words: 1,
              ),
            ),
          ],
          location: Location(),
        ),
      ),
    );
  }
}
