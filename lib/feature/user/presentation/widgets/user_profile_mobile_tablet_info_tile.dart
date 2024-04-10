import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/widgets/text_box.dart';
import 'package:hive_mobile_app/core/utilities/act.dart';
import 'package:hive_mobile_app/core/utilities/constants.dart';
import 'package:hive_mobile_app/feature/user/models/user_model/user_model.dart';
import 'package:hive_mobile_app/feature/user/presentation/widgets/user_profile_follow_info/user_profile_follow_info.dart';
import 'package:intl/intl.dart';

class UserProfileMobileTabletInfoTile extends StatelessWidget {
  const UserProfileMobileTabletInfoTile({
    super.key,
    required this.data,
  });

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kScreenHorizontalPaddingDigit,
                ),
                child: SizedBox(
                  height: 35,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                         FollowInfo(direction: Axis.horizontal,accountName: data.name,),
                        if (data.postingJsonMetadata?.profile?.location != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextBox(
                              onTap: () {},
                              showBorder: true,
                              mainAxisAlignment: MainAxisAlignment.center,
                              borderRadius: 40,
                              icon: Icons.location_on,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kScreenHorizontalPaddingDigit,
                                  vertical: 5),
                              backgroundColor: Colors.transparent,
                              text:
                                  data.postingJsonMetadata!.profile!.location!,
                            ),
                          ),
                        if (data.postingJsonMetadata?.profile?.website != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextBox(
                              onTap: () => Act.launchThisUrl(
                                  data.postingJsonMetadata!.profile!.website!),
                              showBorder: true,
                              mainAxisAlignment: MainAxisAlignment.center,
                              borderRadius: 40,
                              icon: Icons.public,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kScreenHorizontalPaddingDigit,
                                  vertical: 5),
                              backgroundColor: Colors.transparent,
                              text: data.postingJsonMetadata!.profile!.website!,
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextBox(
                            showBorder: true,
                            mainAxisAlignment: MainAxisAlignment.center,
                            borderRadius: 40,
                            icon: Icons.event,
                            padding: const EdgeInsets.symmetric(
                                horizontal: kScreenHorizontalPaddingDigit,
                                vertical: 5),
                            backgroundColor: Colors.transparent,
                            text:
                                DateFormat('d MMMM, yyyy').format(data.created),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            if (!context.isMobile) const Gap(10),
            if (!context.isMobile) const Divider()
          ],
        ),
        if (context.isMobile)
          const Positioned(bottom: -25, left: 0, right: 0, child: Divider())
      ],
    );
  }
}
