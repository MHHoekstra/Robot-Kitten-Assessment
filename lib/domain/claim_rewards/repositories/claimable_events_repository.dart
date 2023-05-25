import 'package:dartz/dartz.dart';
import 'package:robot_kitten_assessment/domain/core/entities/failure.dart';

import '../entities/claimable_event.dart';

abstract interface class ClaimableEventsRepository {
  Future<Either<Failure, ClaimableEvent>> findLatest();
}
