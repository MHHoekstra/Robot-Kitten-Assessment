import 'package:dartz/dartz.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:robot_kitten_assessment/domain/claim_rewards/entities/claimable_event.dart';
import 'package:robot_kitten_assessment/domain/claim_rewards/repositories/claimable_events_repository.dart';
import 'package:robot_kitten_assessment/domain/core/entities/failure.dart';

class DummyClaimableEventsRepository implements ClaimableEventsRepository {
  @override
  Future<Either<Failure, ClaimableEvent>> findLatest() {
    return Future.value(
      right(
        ClaimableEvent(
          title: lorem(paragraphs: 1, words: 3),
          description: lorem(paragraphs: 1, words: 30),
          validUntil: DateTime.now(),
          steps: 5000,
        ),
      ),
    );
  }
}
