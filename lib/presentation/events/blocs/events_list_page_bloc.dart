import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robot_kitten_assessment/application/claim_rewards/interactors/get_latest_claimable_event_interactor.dart';
import 'package:robot_kitten_assessment/presentation/claim_rewards/pages/claim_rewards_page.dart';
import 'package:robot_kitten_assessment/presentation/core/navigation.dart';

class EventsListPageBloc extends Bloc<EventsListEvent, EventsListState> {
  final GetLatestClaimableEventInteractor _claimableEventInteractor;
  EventsListPageBloc(this._claimableEventInteractor)
      : super(EventsListState()) {
    on((EventsListEvent event, emit) async {
      switch (event) {
        case EventsListTappedOnClaimRewards _:
          final result = await _claimableEventInteractor();
          result.fold(
            (l) => null,
            (r) => navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (context) => ClaimRewardsPage(
                  event: r,
                ),
              ),
            ),
          );
      }
    });
  }
}

class EventsListState {}

sealed class EventsListEvent {}

class EventsListTappedOnClaimRewards extends EventsListEvent {}
