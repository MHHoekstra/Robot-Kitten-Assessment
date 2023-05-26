import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';
import 'package:robot_kitten_assessment/presentation/core/components/item_fader.dart';

import '../../core/design_system/app_colors.dart';
import '../blocs/events_list_page_bloc.dart';
import '../components/happening_now_list.dart';
import '../components/this_month_list.dart';
import '../components/this_week_list.dart';
import '../components/your_events_list.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({Key? key}) : super(key: key);

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  late final List<GlobalKey<ItemFaderState>> _faderKeys;
  late final EventsListPageBloc _bloc;

  final _baselineShowDuration = const Duration(
    milliseconds: 200,
  );

  @override
  void initState() {
    _faderKeys = List.generate(1, (_) => GlobalKey<ItemFaderState>());
    _bloc = GetIt.I();
    super.initState();
    _onInit();
    _bloc.add(EventsListInitialize());
  }

  void _onInit() async {
    for (GlobalKey<ItemFaderState> key in _faderKeys) {
      await Future.delayed(const Duration(milliseconds: 40));
      key.currentState?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, EventsListState state) {
        return Scaffold(
          bottomNavigationBar: ItemFader(
            key: _faderKeys[0],
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.martini.withOpacity(0.5),
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: 1,
                backgroundColor: AppColors.black,
                selectedItemColor: AppColors.red,
                unselectedItemColor: AppColors.white,
                onTap: (index) {
                  if (index == 0) {
                    _bloc.add(EventsListTappedOnClaimRewards());
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star_border),
                    label: "Rewards",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: "Events",
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state.yourEvents.isNotEmpty)
                    YourEventsList(
                        events: state.yourEvents,
                        showDurationBaseline: _baselineShowDuration,
                        onCardTap: (Event event) {
                          _bloc.add(EventsListEventTapped(event));
                        }),
                  if (state.happeningNow.isNotEmpty)
                    HappeningNowList(
                      events: state.happeningNow,
                      showDurationBaseline: _baselineShowDuration,
                      showOrder: 2,
                    ),
                  ThisWeekList(),
                  ThisMonthList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
