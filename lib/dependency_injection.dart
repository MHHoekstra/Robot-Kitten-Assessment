import 'package:get_it/get_it.dart';
import 'package:robot_kitten_assessment/application/claim_rewards/interactors/get_latest_claimable_event_interactor.dart';
import 'package:robot_kitten_assessment/domain/claim_rewards/repositories/claimable_events_repository.dart';
import 'package:robot_kitten_assessment/infrastructure/claim_rewards/repositories/dummy_claimable_events_repository.dart';
import 'package:robot_kitten_assessment/presentation/events/blocs/events_list_page_bloc.dart';

void configureDependencyInjection() {
  final instance = GetIt.I;

  //Repositories
  instance.registerLazySingleton<ClaimableEventsRepository>(
      () => DummyClaimableEventsRepository());

  //Interactors
  instance.registerLazySingleton(
      () => GetLatestClaimableEventInteractor(instance()));

  //BLoCs
  instance.registerFactory(() => EventsListPageBloc(instance()));
}
