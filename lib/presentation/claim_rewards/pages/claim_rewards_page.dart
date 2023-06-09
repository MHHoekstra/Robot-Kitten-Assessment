import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:robot_kitten_assessment/domain/claim_rewards/entities/claimable_event.dart';
import 'package:robot_kitten_assessment/presentation/core/components/item_fader.dart';
import 'package:robot_kitten_assessment/presentation/core/components/slow_zooming_image.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_colors.dart';
import 'package:robot_kitten_assessment/presentation/core/design_system/app_fonts.dart';
import 'package:robot_kitten_assessment/presentation/core/navigation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/claim_reward_button.dart';

class ClaimRewardsPage extends StatefulWidget {
  const ClaimRewardsPage({
    super.key,
    required this.event,
  });

  final ClaimableEvent event;

  @override
  State<ClaimRewardsPage> createState() => _ClaimRewardsPageState();
}

class _ClaimRewardsPageState extends State<ClaimRewardsPage> {
  late final List<GlobalKey<ItemFaderState>> keys;

  @override
  void initState() {
    keys = List.generate(8, (_) => GlobalKey<ItemFaderState>());
    super.initState();

    onInit();
  }

  void onInit() async {
    for (GlobalKey<ItemFaderState> key in keys) {
      await Future.delayed(const Duration(milliseconds: 100));
      key.currentState?.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 40,
                ),
                ItemFader(
                  key: keys[0],
                  translateOnHide: false,
                  child: const Text(
                    "Unlocked reward",
                    style: AppFonts.h2,
                  ),
                ),
                ItemFader(
                  key: keys[1],
                  translateOnHide: false,
                  child: IconButton(
                    padding: const EdgeInsets.all(8),
                    iconSize: 24,
                    onPressed: () async {
                      for (GlobalKey<ItemFaderState> key in keys) {
                        await Future.delayed(const Duration(milliseconds: 60));
                        key.currentState?.hide();
                      }
                      await Future.delayed(const Duration(milliseconds: 60));
                      navigatorKey.currentState?.pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const SlowZoomingImage(),
                Container(
                  color: AppColors.purple,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ItemFader(
                            key: keys[2],
                            translateOnHide: false,
                            child: Text(
                              "${widget.event.steps} steps",
                              style: AppFonts.bodyLarge,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Flexible(
                    child: ItemFader(
                      key: keys[3],
                      translateOnHide: false,
                      child: AutoSizeText(
                        widget.event.title,
                        style: AppFonts.h1,
                      ),
                    ),
                  ),
                  ItemFader(
                    key: keys[7],
                    translateOnShow: false,
                    translateOnHide: false,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white,
                        ),
                      ),
                      child: const Text(
                        "EVENT",
                        style: AppFonts.bodyNormal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ItemFader(
                key: keys[4],
                translateOnHide: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Valid until ${widget.event.validUntil.day}/${widget.event.validUntil.month}/${widget.event.validUntil.year}",
                        style: AppFonts.bodyNormal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: ItemFader(
                  key: keys[5],
                  translateOnHide: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          widget.event.description,
                          style: AppFonts.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ItemFader(
              key: keys[6],
              translateOnHide: false,
              translateOnShow: false,
              child: ClaimRewardButton(
                height: 55,
                width: MediaQuery.of(context).size.width,
                onSecondTap: () async {
                  Uri uri = Uri(
                    scheme: 'mailto',
                    path: 'michel.h.hoekstra@gmail.com',
                    query:
                        'subject=Assessment Feedback', //add subject and body here
                  );
                  if (await canLaunchUrl(uri)) {
                    launchUrl(uri);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
