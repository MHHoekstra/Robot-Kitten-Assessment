import 'package:dartz/dartz.dart';
import 'package:robot_kitten_assessment/domain/core/entities/failure.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';

final class GetHappeningNowInteractor {
  const GetHappeningNowInteractor();

  Future<Either<Failure, List<Event>>> call() {
    return Future.value(
      right(
        [
          Event(
            date: DateTime.now(),
            city: "Ponta Grossa",
            state: "Paraná",
            title: "RKS Party",
            going: false,
          ),
        ],
      ),
    );
  }
}
