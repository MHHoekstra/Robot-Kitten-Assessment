import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';
import 'package:robot_kitten_assessment/presentation/core/components/item_fader.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';

import 'your_events_card.dart';

class YourEventsList extends StatefulWidget {
  const YourEventsList({
    super.key,
    required this.events,
    required this.showDurationBaseline,
    this.showOrder = 1,
    required this.onCardTap,
  });

  final List<Event> events;
  final Duration showDurationBaseline;
  final int showOrder;
  final void Function(Event) onCardTap;

  @override
  State<YourEventsList> createState() => _YourEventsListState();
}

class _YourEventsListState extends State<YourEventsList> {
  late final List<GlobalKey<ItemFaderState>> _keys;
  bool _hasAnimated = false;

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
    await Future.delayed(widget.showDurationBaseline);

    setState(() {
      _hasAnimated = true;
    });
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
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Your Events",
              style: AppFonts.h3,
            ),
          ),
        ),
        SizedBox(
          height: 115 + 32,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              return ItemFader(
                key: _keys[index + 1],
                fromRight: true,
                translateOnShow: !_hasAnimated,
                translateOnHide: !_hasAnimated,
                autoShow: _hasAnimated,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: YourEventsCard(
                    event: widget.events[index],
                    onTap: () {
                      widget.onCardTap(widget.events[index]);
                    },
                  ),
                ),
              );
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
