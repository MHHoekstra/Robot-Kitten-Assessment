import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_colors.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';

import 'going_card_button.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function(Event) onTap;
  const EventCard({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.pink,
      child: Ink(
        height: 290,
        child: InkWell(
          onTap: () {
            onTap(event);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${event.date.day}/${event.date.month}/${event.date.year}, ${event.date.hour}:${event.date.minute}",
                              style: AppFonts.h4,
                            ),
                            Flexible(
                              child: AutoSizeText(
                                event.title,
                                style: AppFonts.h2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${event.city}, ${event.state}",
                            style: AppFonts.h4,
                          ),
                          GoingCardButton(
                            initialValue: event.going,
                            onTap: (value) {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  "assets/images/party.jpg",
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
