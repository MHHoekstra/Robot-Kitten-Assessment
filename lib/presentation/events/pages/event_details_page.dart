import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event_details.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/design_system/app_colors.dart';

class EventDetailsPage extends StatefulWidget {
  final EventDetails details;
  const EventDetailsPage({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        color: AppColors.white,
                      ),
                      iconSize: 32),
                  const Text("Event details", style: AppFonts.h3),
                  IconButton(
                    onPressed: () async {
                      final url = Uri.parse(
                          "https://wa.me/554299592911/?text=Congrats");
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      }
                    },
                    icon: const Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
