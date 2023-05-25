import 'package:dartz/dartz.dart';
import 'package:robot_kitten_assessment/domain/claim_rewards/entities/claimable_event.dart';
import 'package:robot_kitten_assessment/domain/claim_rewards/repositories/claimable_events_repository.dart';
import 'package:robot_kitten_assessment/domain/core/entities/failure.dart';

final class GetLatestClaimableEventInteractor {
  final ClaimableEventsRepository _repository;

  const GetLatestClaimableEventInteractor(this._repository);

  Future<Either<Failure, ClaimableEvent>> call() {
    return _repository.findLatest();
  }
}
