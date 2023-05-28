import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';
import 'package:robot_kitten_assessment/presentation/core/components/item_fader.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';

import '../../core/design_system/app_colors.dart';
import '../blocs/events_list_page_bloc.dart';
import '../components/events_list.dart';
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
    _faderKeys = List.generate(2, (_) => GlobalKey<ItemFaderState>());
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
                  ItemFader(
                    key: _faderKeys[1],
                    translateOnShow: false,
                    translateOnHide: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4),
                      child: TextField(
                        autofocus: false,
                        style: AppFonts.bodyNormal,
                        cursorColor: AppColors.white,
                        decoration: InputDecoration(
                          hintText: "Search upcoming events",
                          hintStyle: AppFonts.bodyNormal
                              .copyWith(color: Colors.white24),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppColors.emperor,
                          focusColor: AppColors.white,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state.yourEvents.isNotEmpty)
                    YourEventsList(
                      events: state.yourEvents,
                      showDurationBaseline: _baselineShowDuration,
                      onCardTap: (Event event) {
                        _bloc.add(EventsListEventTapped(event));
                      },
                    ),
                  if (state.happeningNow.isNotEmpty)
                    EventsList(
                      events: state.happeningNow,
                      title: "Happening now",
                      showDurationBaseline: _baselineShowDuration,
                      showOrder: 2,
                      onCardTap: (Event event) {
                        _bloc.add(EventsListEventTapped(event));
                      },
                    ),
                  if (state.happeningNow.isNotEmpty)
                    EventsList(
                      events: state.happeningNow,
                      title: "This week",
                      showDurationBaseline: _baselineShowDuration,
                      showOrder: 3,
                      onCardTap: (Event event) {
                        _bloc.add(EventsListEventTapped(event));
                      },
                    ),
                  if (state.happeningNow.isNotEmpty)
                    EventsList(
                      events: state.happeningNow,
                      title: "This month",
                      showDurationBaseline: _baselineShowDuration,
                      showOrder: 4,
                      onCardTap: (Event event) {
                        _bloc.add(EventsListEventTapped(event));
                      },
                    ),
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
