import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:robot_kitten_assessment/presentation/core/components/item_fader.dart';
import 'package:robot_kitten_assessment/presentation/events/blocs/events_list_page_bloc.dart';

import '../../core/design_system/app_colors.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({Key? key}) : super(key: key);

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  late final List<GlobalKey<ItemFaderState>> _faderKeys;
  late final EventsListPageBloc _bloc;
  @override
  void initState() {
    _faderKeys = List.generate(1, (_) => GlobalKey<ItemFaderState>());
    _bloc = GetIt.I();
    super.initState();
    _onInit();
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
      builder: (context, EventsListState state) => Scaffold(
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
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
