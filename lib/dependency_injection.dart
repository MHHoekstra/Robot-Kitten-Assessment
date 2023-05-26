import 'package:get_it/get_it.dart';
import 'package:robot_kitten_assessment/application/claim_rewards/interactors/get_latest_claimable_event_interactor.dart';
import 'package:robot_kitten_assessment/application/events/interactors/get_event_details_interactor.dart';
import 'package:robot_kitten_assessment/application/events/interactors/get_happening_now_interactor.dart';
import 'package:robot_kitten_assessment/application/events/interactors/get_your_events_interactor.dart';
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
  instance.registerLazySingleton(() => const GetYourEventsInteractor());
  instance.registerLazySingleton(() => const GetHappeningNowInteractor());
  instance.registerLazySingleton(() => const GetEventDetailsInteractor());

  //BLoCs
  instance.registerFactory(
    () => EventsListPageBloc(
      instance(),
      instance(),
      instance(),
      instance(),
    ),
  );
}
