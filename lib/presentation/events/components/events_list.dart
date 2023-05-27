import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';
import 'package:robot_kitten_assessment/presentation/core/components/item_fader.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';
import 'package:robot_kitten_assessment/presentation/events/components/event_card.dart';

class EventsList extends StatefulWidget {
  final List<Event> events;
  final Duration showDurationBaseline;
  final int showOrder;
  final String title;
  final Function(Event) onCardTap;
  const EventsList({
    super.key,
    required this.events,
    required this.showDurationBaseline,
    this.showOrder = 1,
    required this.title,
    required this.onCardTap,
  });

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late final List<GlobalKey<ItemFaderState>> _keys;

  @override
  void initState() {
    super.initState();
    _keys = List.generate(
      widget.events.length + 1,
      (index) => GlobalKey<ItemFaderState>(),
    );
    _showItems();
  }

  void _showItems() async {
    await Future.delayed(widget.showDurationBaseline * widget.showOrder);
    for (GlobalKey<ItemFaderState> key in _keys) {
      await Future.delayed(widget.showDurationBaseline);
      key.currentState?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemFader(
          key: _keys[0],
          translateOnHide: false,
          translateOnShow: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              style: AppFonts.h3,
            ),
          ),
        ),
        ...List.generate(
          widget.events.length,
          (index) => ItemFader(
            key: _keys[index + 1],
            fromRight: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: EventCard(
                event: widget.events[index],
                onTap: widget.onCardTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
