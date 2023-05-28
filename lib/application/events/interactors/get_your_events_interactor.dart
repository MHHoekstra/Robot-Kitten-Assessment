import 'package:dartz/dartz.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:robot_kitten_assessment/domain/core/entities/crew.dart';
import 'package:robot_kitten_assessment/domain/core/entities/failure.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';

final class GetYourEventsInteractor {
  const GetYourEventsInteractor();

  Future<Either<Failure, List<Event>>> call() {
    return Future.value(
      right(
        [
          Event(
            date: DateTime.now(),
            city: "Ponta Grossa",
            state: "Paraná",
            title: "Rainbow Kitten Surprise Party",
            going: true,
            squad: [
              Crew(
                name: lorem(
                  paragraphs: 1,
                  words: 1,
                ),
              ),
            ],
          ),
          Event(
            date: DateTime.now(),
            city: "Ponta Grossa",
            state: "Paraná",
            title: "RKS Party",
            going: true,
            squad: [
              Crew(
                name: lorem(
                  paragraphs: 1,
                  words: 1,
                ),
              ),
            ],
          ),
          Event(
            date: DateTime.now(),
            city: "Ponta Grossa",
            state: "Paraná",
            title: "RKS Party",
            going: true,
            squad: [
              Crew(
                name: lorem(
                  paragraphs: 1,
                  words: 1,
                ),
              ),
            ],
          ),
          Event(
            date: DateTime.now(),
            city: "Ponta Grossa",
            state: "Paraná",
            title: "RKS Party",
            going: true,
            squad: [
              Crew(
                name: lorem(
                  paragraphs: 1,
                  words: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
