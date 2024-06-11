import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/extensions/layout_adapter.dart';
import 'package:hive_mobile_app/core/common/extensions/platform_navigation.dart';
import 'package:hive_mobile_app/core/common/widgets/user_image_name.dart';
import 'package:hive_mobile_app/core/utilities/routes/route_keys.dart';
import 'package:hive_mobile_app/core/utilities/routes/routes.dart';

class SenderToReceiver extends StatelessWidget {
  const SenderToReceiver(
      {super.key,
      required this.from,
      required this.to,
      this.imageRadius,
      this.textStyle});

  final String from;
  final String to;
  final double? imageRadius;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserImageName(
          imageRadius: imageRadius,
          textStyle: textStyle,
          onTap: () => context.platformPushNamed(Routes.userView,
              pathParameters: {RouteKeys.accountName: from}),
          name: from,
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 8 : 15),
          child: const Divider(),
        )),
        UserImageName(
          imageRadius: imageRadius,
          textStyle: textStyle,
          onTap: () => context.platformPushNamed(Routes.userView,
              pathParameters: {RouteKeys.accountName: to}),
          reverse: true,
          name: to,
        ),
      ],
    );
  }
}
