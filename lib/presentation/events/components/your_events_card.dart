import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_colors.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';

class YourEventsCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;
  const YourEventsCard({
    Key? key,
    required this.event,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Material(
            color: AppColors.pink,
            child: Ink(
              width: 300,
              height: 500,
              child: InkWell(
                onTap: onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 12.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${event.date.day}/${event.date.month}/${event.date.year}, ${event.date.hour} ',
                              style: AppFonts.h4,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                    child:
                                        Text(event.title, style: AppFonts.h3)),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "${event.city}, ${event.state}",
                              style: AppFonts.h4,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, right: 15, bottom: 15),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          width: 115,
                          height: 115,
                          'assets/images/party.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.white,
                size: 16,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "You",
                style: AppFonts.bodySmall,
              ),
              if (event.squad.isNotEmpty)
                const Text(
                  " + others",
                  style: AppFonts.bodySmall,
                ),
              const Text(
                " going",
                style: AppFonts.bodySmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}
