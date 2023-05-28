import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/domain/events/entities/event_details.dart';
import 'package:robot_kitten_assessment/presentation/core/components/item_fader.dart';
import 'package:robot_kitten_assessment/presentation/core/components/slow_zooming_image.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/design_system/app_colors.dart';
import '../components/going_button.dart';

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
  late final List<GlobalKey<ItemFaderState>> _keys;

  @override
  void initState() {
    super.initState();
    _keys = List.generate(6, (index) => GlobalKey<ItemFaderState>());
    _showItems();
  }

  void _showItems() async {
    for (GlobalKey<ItemFaderState> key in _keys) {
      await Future.delayed(const Duration(milliseconds: 100));
      key.currentState?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemFader(
              key: _keys[0],
              child: Padding(
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
                            "https://wa.me/554299592911/?text=Check this out ${widget.details.title}");
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
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SlowZoomingImage(),
                    ItemFader(
                      key: _keys[1],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(widget.details.title, style: AppFonts.h2),
                      ),
                    ),
                    ItemFader(
                      key: _keys[2],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.details.description,
                          style: AppFonts.bodyNormal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ItemFader(
                      key: _keys[3],
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: DetailsDateTile(),
                      ),
                    ),
                    ItemFader(
                      key: _keys[4],
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: DetailsLocationTile(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GoingButton(
              initialValue: widget.details.going,
              onTap: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsLocationTile extends StatelessWidget {
  const DetailsLocationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.white,
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "NDSM Docklands",
              style: AppFonts.bodyLarge,
            ),
            Text(
              "T.T. Neveritaweg 15",
              style: AppFonts.bodyNormal,
            ),
            Text(
              "1033 RG Amsterdam",
              style: AppFonts.bodyNormal,
            ),
          ],
        )
      ],
    );
  }
}

class DetailsDateTile extends StatelessWidget {
  const DetailsDateTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.calendar_today_outlined,
          color: AppColors.white,
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Thu, September 08",
              style: AppFonts.bodyLarge,
            ),
            Text(
              "6:30 PM - 3:00 AM",
              style: AppFonts.bodyNormal,
            ),
          ],
        )
      ],
    );
  }
}
