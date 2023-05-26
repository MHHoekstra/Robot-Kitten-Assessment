import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robot_kitten_assessment/application/claim_rewards/interactors/get_latest_claimable_event_interactor.dart';
import 'package:robot_kitten_assessment/application/events/interactors/get_event_details_interactor.dart';
import 'package:robot_kitten_assessment/application/events/interactors/get_happening_now_interactor.dart';
import 'package:robot_kitten_assessment/application/events/interactors/get_your_events_interactor.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';
import 'package:robot_kitten_assessment/presentation/claim_rewards/pages/claim_rewards_page.dart';
import 'package:robot_kitten_assessment/presentation/core/navigation.dart';

import '../pages/event_details_page.dart';

class EventsListPageBloc extends Bloc<EventsListEvent, EventsListState> {
  final GetLatestClaimableEventInteractor _claimableEventInteractor;
  final GetYourEventsInteractor _getYourEventsInteractor;
  final GetHappeningNowInteractor _happeningNowInteractor;
  final GetEventDetailsInteractor _getEventDetailsInteractor;

  EventsListPageBloc(
      this._claimableEventInteractor,
      this._getYourEventsInteractor,
      this._happeningNowInteractor,
      this._getEventDetailsInteractor)
      : super(
          const EventsListState(
            yourEvents: [],
            happeningNow: [],
          ),
        ) {
    on((EventsListEvent event, emit) async {
      switch (event) {
        case EventsListEventTapped event:
          final eventDetailsResult =
              await _getEventDetailsInteractor(event.event);
          eventDetailsResult.fold(
            (l) => null,
            (r) => navigatorKey.currentState?.push(
              CupertinoPageRoute(
                builder: (context) => EventDetailsPage(details: r),
              ),
            ),
          );
          break;
        case EventsListInitialize _:
          final yourEventsResult = await _getYourEventsInteractor();
          final yourEvents = yourEventsResult.getOrElse(() => <Event>[]);
          final happeningNowResult = await _happeningNowInteractor();
          final happeningNow = happeningNowResult.getOrElse(() => <Event>[]);

          emit(
            EventsListState(
              yourEvents: yourEvents,
              happeningNow: happeningNow,
            ),
          );
          break;
        case EventsListTappedOnClaimRewards _:
          final result = await _claimableEventInteractor();
          result.fold(
            (l) => null,
            (r) => navigatorKey.currentState?.push(
              CupertinoPageRoute(
                builder: (context) => ClaimRewardsPage(
                  event: r,
                ),
              ),
            ),
          );
          break;
      }
    });
  }
}

class EventsListState {
  final List<Event> yourEvents;
  final List<Event> happeningNow;

  const EventsListState({
    required this.yourEvents,
    required this.happeningNow,
  });
}

sealed class EventsListEvent {}

class EventsListTappedOnClaimRewards extends EventsListEvent {}

class EventsListInitialize extends EventsListEvent {}

class EventsListEventTapped extends EventsListEvent {
  final Event event;

  EventsListEventTapped(this.event);
}
